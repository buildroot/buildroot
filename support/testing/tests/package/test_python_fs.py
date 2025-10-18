import infra.basetest


class TestHostPythonFs(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-fs"]

    def test_run(self):
        cmd = ["host/bin/python3", "-c", "import fs; fs.open_fs('mem://'); fs.open_fs('temp://')"]
        infra.run_cmd_on_host(self.builddir, cmd)
