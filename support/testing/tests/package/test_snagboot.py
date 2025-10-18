import infra.basetest


class TestHostSnagboot(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-snagboot"]
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_HOST_SNAGBOOT=y
        """

    def test_run(self):
        cmd = ["host/bin/snagrecover", "--help"]
        infra.run_cmd_on_host(self.builddir, cmd)

        cmd = ["host/bin/snagflash", "--help"]
        infra.run_cmd_on_host(self.builddir, cmd)
