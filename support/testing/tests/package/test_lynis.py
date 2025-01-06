import os

import infra.basetest


class TestLynis(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_LYNIS=y
        """

    def login(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

    def test_run(self):
        self.login()
        self.assertRunOk("which awk")
        self.assertRunOk("which stat")
        self.assertRunOk("which zgrep")
        self.assertRunOk("lynis show version", timeout=90)
