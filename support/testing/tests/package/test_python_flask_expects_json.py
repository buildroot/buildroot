from tests.package.test_python import TestPythonPackageBase
import os
import time


class TestPythonPy3FlaskExpectsJson(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_LIBCURL=y
        BR2_PACKAGE_LIBCURL_CURL=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_FLASK=y
        BR2_PACKAGE_PYTHON_FLASK_EXPECTS_JSON=y
        """
    sample_scripts = ["tests/package/sample_python_flask_expects_json.py"]
    timeout = 60

    def try_json(self, payload, expects):
        cmd = """curl -s -o /dev/null -w "%{http_code}\\n" -X POST """
        cmd += """-H "Content-Type: application/json" -d '%s' http://127.0.0.1:5000""" % payload
        output, exit_code = self.emulator.run(cmd, timeout=self.timeout)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], str(expects))

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()
        cmd = "FLASK_APP=%s %s -m flask run > /dev/null 2>&1 &" % (os.path.basename(self.sample_scripts[0]),
                                                                   self.interpreter)
        _, exit_code = self.emulator.run(cmd, timeout=self.timeout)

        # Give enough time for the flask server to start up
        time.sleep(15)

        self.try_json("""{"email": "test", "name": "test"}""", 200)
        self.try_json("""{"email": "test", "name": 2}""", 400)
        self.try_json("""{"email": "test"}""", 400)
