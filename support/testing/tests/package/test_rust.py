import os

import infra.basetest


class TestRustBase(infra.basetest.BRTest):

    def login(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()


class TestRustBin(TestRustBase):
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_NEON=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_SYSTEM_DHCP="eth0"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_HOST_RUSTC=y
        BR2_PACKAGE_RIPGREP=y
        """

    def test_run(self):
        self.login()
        self.assertRunOk("rg Buildroot /etc/issue")


class TestRust(TestRustBase):
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_NEON=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_SYSTEM_DHCP="eth0"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_HOST_RUSTC=y
        BR2_PACKAGE_HOST_RUST=y
        BR2_PACKAGE_RIPGREP=y
        """

    def test_run(self):
        self.login()
        self.assertRunOk("rg Buildroot /etc/issue")
