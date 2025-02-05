import time

from tests.package.test_python import TestPythonPackageBase


class TestPythonWaitress(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_FLASK=y
        BR2_PACKAGE_PYTHON_WAITRESS=y
        """

    sample_scripts = ["tests/package/sample_python_flask.py"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()
        cmd = self.interpreter + " -m waitress sample_python_flask:app > /dev/null 2>&1 &"
        # give some time to setup the server
        _, exit = self.emulator.run(cmd, timeout=self.timeout)

        # Give enough time for the uvicorn server to start up
        for attempt in range(30):
            time.sleep(1)

            cmd = "wget -q -O - http://127.0.0.1:8080/"
            output, exit_code = self.emulator.run(cmd, timeout=self.timeout)
            if exit_code == 0:
                self.assertEqual(output[0], 'Hello, World!')
                break
        self.assertEqual(exit_code, 0, "Timeout while waiting for django server")
