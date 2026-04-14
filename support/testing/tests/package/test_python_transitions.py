import os

from tests.package.test_python import TestPythonPackageBase


class TestPythonTransitions(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_TRANSITIONS=y
        """
    sample_scripts = ["tests/package/sample_python_transitions.py"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()

        cmd = self.interpreter + " " + os.path.basename(self.sample_scripts[0])
        output, exit_code = self.emulator.run(cmd, timeout=15)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output, [
            'caffeinated',
            'caffeinated_dithering',
            'caffeinated_dithering',
            'caffeinated_running',
            'caffeinated_running',
            'standing'
        ])
