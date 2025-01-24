from tests.package.test_lua import TestLuaBase


class TestLuaLuaperiphery(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_LUA_PERIPHERY=y
        """

    def test_run(self):
        self.login()
        self.module_test("periphery")


class TestLuajitLuaperiphery(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_LUA_PERIPHERY=y
        """

    def test_run(self):
        self.login()
        self.module_test("periphery")
