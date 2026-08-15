import os

import infra.basetest


class TestCramfs(infra.basetest.BRTest):
    kern_frag = \
        infra.filepath("tests/fs/test_cramfs/linux-cramfs.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.44"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_CRAMFS=y
        BR2_TARGET_ROOTFS_CRAMFS=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        disk = os.path.join(self.builddir, "images", "rootfs.cramfs")
        kern = os.path.join(self.builddir, "images", "Image")
        bootargs = ["root=/dev/vda"]
        qemu_opts = ["-M", "virt", "-cpu", "cortex-a57", "-m", "512M",
                     "-drive", f"file={disk},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # We check our root filesystem is in cramfs format.
        cmd = "mount | grep '/dev/root on / type cramfs'"
        self.assertRunOk(cmd)

        # We run cramfsck on the filesystem.
        self.assertRunOk("cramfsck -v /dev/vda")
