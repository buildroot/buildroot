from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Jc(TestPythonPackageBase):
    __test__ = True
    # We deliberately run the test without the optional dependencies,
    # as this configuration is less tested upstream.
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_JC=y
        """
    timeout = 60

    def test_run(self):
        self.login()
        cmd = "jc -h > /dev/null 2>&1"
        self.assertRunOk(cmd, timeout=self.timeout)
        cmd = "jc id | grep -q root"
        self.assertRunOk(cmd, timeout=self.timeout)
        cmd = "jc env | grep -q PATH"
        self.assertRunOk(cmd, self.timeout)
