import os
import infra.basetest


class TestRuby(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_RUBY=y
        BR2_PACKAGE_ZLIB=y
        """

    def version_test(self):
        cmd = "ruby -v"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)

    def zlib_test(self, timeout=-1):
        cmd = "ruby -e 'require \"zlib\"'"
        _, exit_code = self.emulator.run(cmd, timeout)
        self.assertEqual(exit_code, 0)

    def login(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

    def test_run(self):
        self.login()
        self.version_test()
        self.zlib_test()
