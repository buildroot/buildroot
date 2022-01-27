import os

import infra.basetest


class TestPhpApcu(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_PHP=y
        BR2_PACKAGE_PHP_SAPI_CLI=y
        BR2_PACKAGE_PHP_APCU=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()

        self.assertRunOk("mkdir /etc/php.d")
        self.assertRunOk("echo 'extension=apcu.so' > /etc/php.d/apcu.ini")
        # enable_cli enables APC for the CLI version of PHP, which is what we
        # use in this test case.
        self.assertRunOk("echo 'apc.enable_cli=1' >> /etc/php.d/apcu.ini")

        output, exit_code = self.emulator.run("php --ri apcu | sed '/^$/d'")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "apcu")
        self.assertEqual(output[1], "APCu Support => Enabled")
        # Do not check the version value in order to avoid a test failure when
        # bumping package version.
        self.assertEqual(output[2][0:11], "Version => ")
