from tests.package.test_perl import TestPerlBase
import os


class TestPerlDBDmysql(TestPerlBase):
    """
    package:
        DBD-mysql   XS
    direct dependencies:
        DBI   XS
    """

    config = TestPerlBase.config + \
        """
        BR2_PACKAGE_PERL=y
        BR2_PACKAGE_PERL_DBD_MYSQL=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="120M"
        """

    def login(self):
        ext2_file = os.path.join(self.builddir, "images", "rootfs.ext2")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-drive", "file=%s,if=scsi,format=raw" % ext2_file],
                           kernel_cmdline=["rootwait", "root=/dev/sda"])
        self.emulator.login()

    def test_run(self):
        self.login()
        self.module_test("DBI")
        self.module_test("DBD::mysql")
