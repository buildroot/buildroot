from tests.package.test_python import TestPythonPackageBase
import os


class TestPythonPyroute2(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_PYROUTE2=y
        """
    sample_scripts = ["tests/package/sample_python_pyroute2.py"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()
        # helpful for debugging, if the test fails the run log will
        # show if the interface was ready
        output, exit_code = self.emulator.run('ip addr show', timeout=15)
        self.assertEqual(exit_code, 0)

        cmd = self.interpreter + " " + os.path.basename(self.sample_scripts[0])
        _, exit_code = self.emulator.run(cmd, timeout=15)
        self.assertEqual(exit_code, 0)
