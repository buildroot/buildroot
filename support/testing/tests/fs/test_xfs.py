import os

import infra.basetest


class TestXfs(infra.basetest.BRTest):
    kern_frag = \
        infra.filepath("tests/fs/test_xfs/linux-xfs.fragment")
    xfs_label = "BR_TEST"
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.18"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_TARGET_ROOTFS_XFS=y
        BR2_TARGET_ROOTFS_XFS_LABEL="{xfs_label}"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        disk = os.path.join(self.builddir, "images", "rootfs.xfs")
        kern = os.path.join(self.builddir, "images", "Image")
        bootargs = ["root=/dev/vda"]
        qemu_opts = ["-M", "virt", "-cpu", "cortex-a57", "-m", "512M",
                     "-drive", f"file={disk},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # We check our root filesystem is in xfs format.
        cmd = "mount | grep '/dev/root on / type xfs'"
        self.assertRunOk(cmd)

        # We try to write data on the root filesystem.
        msg = "Hello Buildroot"
        fname = "/root/file.txt"
        self.assertRunOk(f"echo '{msg}' > {fname}")

        # We sync and drop all caches, to make sure we will read back
        # from the filsystem.
        self.assertRunOk("sync")
        self.assertRunOk("echo 3 > /proc/sys/vm/drop_caches")

        # We check we can read back out data.
        out, ret = self.emulator.run(f"cat {fname}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)
