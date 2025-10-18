import infra.basetest


class TestHostPythonSerial(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-serial"]

    def test_run(self):
        cmd = ["host/bin/python3", "-c", "import serial"]
        infra.run_cmd_on_host(self.builddir, cmd)

        cmd = ["host/bin/python3", "-m", "serial.tools.list_ports"]
        infra.run_cmd_on_host(self.builddir, cmd)
