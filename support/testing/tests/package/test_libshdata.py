import os

import infra.basetest


class TestLibshdata(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LIBSHDATA=y
        BR2_PACKAGE_LIBSHDATA_STRESS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()

        # Just run libshdata-stress.
        # This ensures that library are well compiled and that all dependencies
        # are met using Parrot Alchemy build system.
        self.assertRunOk("libshdata-stress")
