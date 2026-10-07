import os

import infra.basetest


class TestQuazipBase(infra.basetest.BRTest):
    __test__ = False
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_QUAZIP=y
        BR2_PACKAGE_QUAZIP_INSTALL_TESTS=y
        BR2_TARGET_ROOTFS_CPIO=y
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # qztest returns non-zero if any of the tests failed
        self.assertRunOk("/usr/bin/qztest", 120)


class TestQuazipQt5(TestQuazipBase):
    __test__ = True
    config = TestQuazipBase.config + \
        """
        BR2_PACKAGE_QT5=y
        """


class TestQuazipQt6(TestQuazipBase):
    __test__ = True
    config = TestQuazipBase.config + \
        """
        BR2_PACKAGE_QT6=y
        """
