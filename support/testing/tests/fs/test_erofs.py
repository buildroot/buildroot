import os

import infra.basetest


class TestErofs(infra.basetest.BRTest):
    kern_frag = \
        infra.filepath("tests/fs/test_erofs/linux-erofs.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.46"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_EROFS_UTILS=y
        BR2_TARGET_ROOTFS_EROFS=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        root_dev = "/dev/vda"
        disk = os.path.join(self.builddir, "images", "rootfs.erofs")
        kern = os.path.join(self.builddir, "images", "Image")
        bootargs = [f"root={root_dev}", "console=ttyAMA0"]
        qemu_opts = ["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                     "-drive", f"file={disk},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # We check our root filesystem is in erofs format.
        cmd = "mount | grep '/dev/root on / type erofs'"
        self.assertRunOk(cmd)

        # Since we are on a read-only mounted filesystem, we can run a
        # check...
        self.assertRunOk(f"fsck.erofs {root_dev}")

        # We check we can dump the superblock.
        self.assertRunOk(f"dump.erofs -s {root_dev}")

        # We check we can dump statistics on the image.
        self.assertRunOk(f"dump.erofs -S {root_dev}")
