import os

import infra.basetest


class TestBtrfs(infra.basetest.BRTest):
    kern_frag = \
        infra.filepath("tests/fs/test_btrfs/linux-btrfs.fragment")
    btrfs_label = "BR_TEST"
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.39"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_BTRFS_PROGS=y
        BR2_TARGET_ROOTFS_BTRFS=y
        BR2_TARGET_ROOTFS_BTRFS_LABEL="{btrfs_label}"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        disk = os.path.join(self.builddir, "images", "rootfs.btrfs")
        kern = os.path.join(self.builddir, "images", "Image")
        bootargs = ["root=/dev/vda", "console=ttyAMA0"]
        qemu_opts = ["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                     "-drive", f"file={disk},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # We check our root filesystem is in btrfs format.
        cmd = "mount | grep '/dev/root on / type btrfs'"
        self.assertRunOk(cmd)

        # We show the root filesystem info with btrfs-progs, using the
        # target btrfs-progs.
        self.assertRunOk("btrfs filesystem show /")

        # We query the label and check it is the one from the
        # Buildroot config.
        out, ret = self.emulator.run("btrfs filesystem label /")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], self.btrfs_label)

        # We try to write data on the root filesystem.
        self.assertRunOk("echo 'Hello Buildroot' > /root/file.txt")
        self.assertRunOk("sync")
