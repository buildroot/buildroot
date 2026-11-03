import infra.basetest


class TestHostSwugenerator(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-swugenerator"]
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_HOST_SWUGENERATOR=y
        """

    def test_run(self):
        cmd = ["host/bin/swugenerator", "--help"]
        infra.run_cmd_on_host(self.builddir, cmd)
