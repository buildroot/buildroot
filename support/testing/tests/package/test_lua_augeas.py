from tests.package.test_lua import TestLuaBase


class TestLuaLuaAugeas(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_AUGEAS=y
        BR2_PACKAGE_LUA_AUGEAS=y
        """

    def test_run(self):
        self.login()
        self.module_test("augeas")


class TestLuajitLuaAugeas(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_AUGEAS=y
        BR2_PACKAGE_LUA_AUGEAS=y
        """

    def test_run(self):
        self.login()
        self.module_test("augeas")
