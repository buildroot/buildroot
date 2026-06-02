import os

import infra.basetest


class TestAtop(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ATOP=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        cmd = "atop -V | grep '^Version'"
        self.assertRunOk(cmd)

        cmd = "atop -a 1 2 | grep '% *atop *$'"
        self.assertRunOk(cmd)
