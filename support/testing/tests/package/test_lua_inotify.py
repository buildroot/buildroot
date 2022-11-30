from tests.package.test_lua import TestLuaBase


class TestLuaInotify(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_LUA_INOTIFY=y
        """

    def test_run(self):
        self.login()
        self.module_test("inotify")


class TestLuajitInotify(TestLuaBase):
    config = TestLuaBase.config + \
        """
        BR2_PACKAGE_LUAJIT=y
        BR2_PACKAGE_LUA_INOTIFY=y
        """

    def test_run(self):
        self.login()
        self.module_test("inotify")
