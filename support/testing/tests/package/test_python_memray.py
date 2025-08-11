from tests.package.test_python import TestPythonPackageBase
import os


class TestPythonMemray(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_MEMRAY=y
        """
    sample_scripts = ["tests/package/sample_python_memray.py"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()
        test_trace = "/tmp/trace.bin"
        test_flame = "/tmp/trace.html"

        # profile the sample script
        cmd = "%s -m memray run -o %s %s" % (self.interpreter, test_trace, os.path.basename(self.sample_scripts[0]))
        output, exit_code = self.emulator.run(cmd, timeout=15)
        self.assertEqual(exit_code, 0)
        self.assertIn("Hello World!", output)

        # generate statistics
        cmd = "%s -m memray stats %s" % (self.interpreter, test_trace)
        output, exit_code = self.emulator.run(cmd, timeout=15)
        self.assertEqual(exit_code, 0)
        self.assertTrue(any(filter(lambda line: "alloc" in line, output)))

        # generate flamegraph
        cmd = "%s -m memray flamegraph -o %s %s" % (self.interpreter, test_flame, test_trace)
        output, exit_code = self.emulator.run(cmd, timeout=15)
        self.assertEqual(exit_code, 0)
        # rough plausibility check if the output file is HTML
        cmd = "grep -i '</html>' %s" % (test_flame,)
        self.assertEqual(exit_code, 0)
