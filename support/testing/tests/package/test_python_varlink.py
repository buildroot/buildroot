import os

from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Varlink(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_VARLINK=y
        """
    sample_scripts = ["tests/package/test_python_varlink/sample_python_varlink.py",
                      "tests/package/test_python_varlink/org.example.test.varlink"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()
        # we need to supress any output here as otherwise the commnd output parsing
        # gets confused for the second command
        cmd = "%s %s  > /dev/null 2>&1 &" % (self.interpreter, os.path.basename(self.sample_scripts[0]))

        _, exit_code = self.emulator.run(cmd, timeout=self.timeout)

        varlink_cli_call = "-m varlink.cli call 'unix:@test/org.example.test.Ping' '{\"ping\": \"hello\"}'"
        unprettyprint = "| python -m json.tool --compact"
        cmd = "%s %s %s" % (self.interpreter, varlink_cli_call, unprettyprint)
        output, exit_code = self.emulator.run(cmd, timeout=self.timeout)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], '{"pong":"hello"}')
