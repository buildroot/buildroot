from tests.package.test_python import TestPythonPackageBase
import os
import time


class TestPythonPy3Flask(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_FLASK=y
        """
    sample_scripts = ["tests/package/sample_python_flask.py"]
    timeout = 60

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()
        cmd = "FLASK_APP=%s %s -m flask run > /dev/null 2>&1 &" % (os.path.basename(self.sample_scripts[0]),
                                                                   self.interpreter)
        _, exit_code = self.emulator.run(cmd, timeout=self.timeout)

        # Give enough time for the flask server to start up
        for attempt in range(30):
            time.sleep(1)

            cmd = "wget -q -O - http://127.0.0.1:5000/"
            output, exit_code = self.emulator.run(cmd, timeout=self.timeout)
            if exit_code == 0:
                self.assertEqual(output[0], 'Hello, World!')
                break
        else:
            self.assertTrue(False, "Timeout while waiting for flask server")
