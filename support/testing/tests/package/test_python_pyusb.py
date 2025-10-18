import infra.basetest


class TestHostPythonPyusb(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-pyusb"]

    def test_run(self):
        cmd = ["host/bin/python3", "-c", "import usb"]
        infra.run_cmd_on_host(self.builddir, cmd)
