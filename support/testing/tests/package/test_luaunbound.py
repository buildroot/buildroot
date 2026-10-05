from tests.package.test_lua import TestLuaBase


class TestLuaLuaunbound(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_LUAUNBOUND=y
        """

    def test_run(self):
        self.login()
        self.module_test("lunbound")


class TestLuajitLuaunbound(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_LUAUNBOUND=y
        """

    def test_run(self):
        self.login()
        self.module_test("lunbound")
