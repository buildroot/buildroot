import os

import infra.basetest


class TestPhpPam(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_PHP=y
        BR2_PACKAGE_PHP_SAPI_CLI=y
        BR2_PACKAGE_PHP_PAM=y
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
        self.assertRunOk("echo 'extension=pam.so'> /etc/php.d/pam.ini")

        output, exit_code = self.emulator.run("php --ri pam | sed '/^$/d'")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "pam")
        self.assertEqual(output[1], "PAM support => enabled")
        # Do not check the version value in order to avoid test failure when
        # bumping package version
        self.assertEqual(output[2][0:21], "Extension version => ")
