import os

import infra.basetest


class TestSQLiteCpp(infra.basetest.BRTest):
    br2_external = [infra.filepath("tests/package/br2-external/sqlitecpp")]
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_SQLITECPP=y
        BR2_PACKAGE_SQLITECPP_TEST=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        output, exit_code = self.emulator.run("/usr/bin/sqlitecpp-test")
        self.assertEqual(exit_code, 0, output)
        self.assertIn("Banana: Yellow", output)
