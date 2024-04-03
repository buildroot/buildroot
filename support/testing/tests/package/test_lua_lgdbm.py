from tests.package.test_lua import TestLuaBase


class TestLuaLgdbm(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_LUA_LGDBM=y
        """

    def test_run(self):
        self.login()
        self.module_test("gdbm")
