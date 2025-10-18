import infra.basetest


class TestHostPythonXmodem(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-xmodem"]

    def test_run(self):
        cmd = ["host/bin/python3", "-c", "import xmodem"]
        infra.run_cmd_on_host(self.builddir, cmd)
