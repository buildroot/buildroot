import os

import infra.basetest


class TestPhpLuaLua(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_PHP=y
        BR2_PACKAGE_PHP_SAPI_CLI=y
        BR2_PACKAGE_PHP_LUA=y
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
        self.assertRunOk("echo 'extension=lua.so' > /etc/php.d/lua.ini")

        output, exit_code = self.emulator.run("php --ri lua | sed '/^$/d'")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "lua")
        self.assertEqual(output[1], "lua support => enabled")
        # Do not check the version value in order to avoid a test failure when
        # bumping package version.
        self.assertEqual(output[2][0:25], "lua extension version => ")


class TestPhpLuaLuajit(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_PHP=y
        BR2_PACKAGE_PHP_SAPI_CLI=y
        BR2_PACKAGE_PHP_LUA=y
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
        self.assertRunOk("echo 'extension=lua.so' > /etc/php.d/lua.ini")

        output, exit_code = self.emulator.run("php --ri lua | sed '/^$/d'")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "lua")
        self.assertEqual(output[1], "lua support => enabled")
        # Do not check the version value in order to avoid a test failure when
        # bumping package version.
        self.assertEqual(output[2][0:25], "lua extension version => ")
