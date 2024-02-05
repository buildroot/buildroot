import os

from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Uvloop(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_UVLOOP=y
        """
    sample_scripts = ["tests/package/sample_python_uvloop.py"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()

        cmd = "%s %s" % (self.interpreter, os.path.basename(self.sample_scripts[0]))
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "Hello world!")
