from tests.package.test_lua import TestLuaBase


class TestLuaLuazlib(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_LUA_ZLIB=y
        """

    def test_run(self):
        self.login()
        self.module_test("zlib")


class TestLuajitLuazlib(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_LUA_ZLIB=y
        """

    def test_run(self):
        self.login()
        self.module_test("zlib")
