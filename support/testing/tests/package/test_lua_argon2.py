from tests.package.test_lua import TestLuaBase


class TestLuaLuaArgon2(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_LUA_ARGON2=y
        """

    def test_run(self):
        self.login()
        self.module_test("argon2")


class TestLuajitLuaArgon2(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_LUA_ARGON2=y
        """

    def test_run(self):
        self.login()
        self.module_test("argon2")
