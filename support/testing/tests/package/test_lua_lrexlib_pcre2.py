from tests.package.test_lua import TestLuaBase


class TestLuaLrexlibPCRE2(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_LUA_LREXLIB_PCRE2=y
        """

    def test_run(self):
        self.login()
        self.module_test("rex_pcre2")


class TestLuajitLrexlibPCRE2(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_LUA_LREXLIB_PCRE2=y
        """

    def test_run(self):
        self.login()
        self.module_test("rex_pcre2")
