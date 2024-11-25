import os
import time

import infra.basetest


class TestBcc(infra.basetest.BRTest):
    # This test is using a Kernel >= 5.2, so it will use
    # CONFIG_IKHEADERS. Those Kernel headers are unpacked from
    # "/sys/kernel/kheaders.tar.xz" with a "tar" invocation. The
    # Busybox "tar" command invoked by bcc fails to unpack the Kernel
    # tar archive. We need the GNU Tar package. The Kernel also needs
    # few extra config options, for running execsnoop.
    kern_fragment = \
        infra.filepath("tests/package/test_bcc/linux-bcc.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.32"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_BCC=y
        BR2_PACKAGE_TAR=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                                    "-drive", f"file={drive},if=virtio,format=raw"])
        self.emulator.login()

        log = "/root/execsnoop.log"
        test_cmd = "/bin/sleep 1"

        # bcc needs debugs to be mounted.
        self.assertRunOk("mount -t debugfs none /sys/kernel/debug/")

        # Generate some exec()s activity in background. We explicitly
        # call for "/bin/sleep" rather than just "sleep" to avoid
        # using any shell builtin and make sure we will exec() the
        # binary.
        cmd = f"while true ; do {test_cmd} ; done &"
        self.assertRunOk(cmd)

        # Run execsnoop, also in background...
        cmd = f"/usr/share/bcc/tools/execsnoop > {log} &"
        self.assertRunOk(cmd)

        for attempt in range(3):
            # Wait a bit, to let execsnoop to start and log some data.
            time.sleep(40 * self.timeout_multiplier)

            # We check that the log file contains some data.
            cmd = f"test -s {log}"
            _, ret = self.emulator.run(cmd)
            if ret == 0:
                break
        else:
            self.fail(f"Timeout while waiting for data in {log}.")

        # Kill our background execsnoop execution.
        self.assertRunOk("kill $!")

        # Check we have captured execution occurrences of out test
        # command.
        cmd = f"grep -Foc '{test_cmd}' {log}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertGreater(int(out[0]), 0)
