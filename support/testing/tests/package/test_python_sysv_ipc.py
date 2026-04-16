import os
from tests.package.test_python import TestPythonPackageBase


class TestPythonSysVIPC(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_SYSV_IPC=y
        """
    sample_scripts = ["tests/package/sample_python_sysv_ipc.py",
                      "tests/package/test_python_sysv_ipc/ping.py",
                      "tests/package/test_python_sysv_ipc/pong.py"]

    def test_run(self):
        self.login()
        self.check_sample_scripts_exist()

        cmd = self.interpreter + " " + os.path.basename(self.sample_scripts[0])
        output, ret = self.emulator.run(cmd, timeout=self.timeout)

        self.assertEqual(ret, 0)
        self.assertEqual(output, [
            'ping 0',
            'pong 0',
            'ping 1',
            'pong 1',
            'ping 2',
            'pong 2',
            'ping 3',
            'pong 3',
            'ping 4',
            'pong 4',
            'ping 5',
            'pong 5',
        ])
