import infra.basetest


class TestHostPythonCrccheck(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-crccheck"]

    def test_run(self):
        cmd = ["host/bin/python3", "-c", "import crccheck; print(crccheck.crc.Crc32.calc(bytearray.fromhex('DEADBEEF')))"]
        res = infra.run_cmd_on_host(self.builddir, cmd)
        self.assertEqual(res.strip(), "2090640218")
