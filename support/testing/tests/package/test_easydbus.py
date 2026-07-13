import infra.basetest

from tests.package.test_lua import TestLuaBase


class EasyDBusBase(TestLuaBase):
    rootfs_overlay = \
        infra.filepath("tests/package/test_easydbus/rootfs-overlay")
    config = TestLuaBase.config + \
        f"""
        BR2_PACKAGE_DBUS=y
        BR2_PACKAGE_EASYDBUS=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        """

    def signal_round_trip(self):
        cmd = "lua /root/easydbus-sample.lua"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "OK")


class TestLuaEasyDBus(EasyDBusBase):
    config = EasyDBusBase.config + \
        """
        BR2_PACKAGE_LUA=y
        """

    def test_run(self):
        self.login()
        self.module_test("easydbus")
        self.signal_round_trip()


class TestLuajitEasyDBus(EasyDBusBase):
    config = EasyDBusBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        """

    def test_run(self):
        self.login()
        self.module_test("easydbus")
        self.signal_round_trip()
