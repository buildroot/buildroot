import os

import infra.basetest


class TestGoBase(infra.basetest.BRTest):

    def login(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()


class TestGoBin(TestGoBase):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_PACKAGE_HOST_GO=y
        BR2_PACKAGE_HOST_GO_BIN=y
        BR2_PACKAGE_FLANNEL=y
        """

    def test_run(self):
        self.login()
        self.assertRunOk("/opt/bin/flanneld -h")


class TestGoSource(TestGoBase):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_PACKAGE_HOST_GO=y
        BR2_PACKAGE_HOST_GO_SRC=y
        BR2_PACKAGE_FLANNEL=y
        """

    def test_run(self):
        self.login()
        self.assertRunOk("/opt/bin/flanneld -h")
