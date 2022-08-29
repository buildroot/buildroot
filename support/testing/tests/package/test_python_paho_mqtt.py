from tests.package.test_python import TestPythonPackageBase
import os


class TestPythonPahoMQTT(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_MOSQUITTO=y
        BR2_PACKAGE_MOSQUITTO_BROKER=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_PAHO_MQTT=y
        """
    sample_scripts = ["tests/package/sample_python_paho_mqtt.py"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()

        cmd = "%s %s" % (self.interpreter, os.path.basename(self.sample_scripts[0]))
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "Hello, World!")
