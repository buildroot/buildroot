from tests.package.test_python import TestPythonPackageBase


class TestPythonQuestionary(TestPythonPackageBase):
    sample_scripts = ["tests/package/sample_python_questionary.py"]

    def run_sample_scripts(self):
        cmd = self.interpreter + " sample_python_questionary.py"
        output, exit_code = self.emulator.run(cmd, timeout=10)
        self.assertIn("Press any key to continue...", output[0])
        self.assertEqual(exit_code, 1)


class TestPythonPy3Questionary(TestPythonQuestionary):
    __test__ = True
    config = TestPythonQuestionary.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_QUESTIONARY=y
        """
