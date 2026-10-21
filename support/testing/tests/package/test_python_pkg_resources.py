import infra.basetest


class TestHostPythonPkgResources(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-pkg-resources"]

    def test_run(self):
        cmd = ["host/bin/python3", "-I", "-c",
               "import pkg_resources; "
               "assert '__init__.py' in pkg_resources.resource_listdir('pkg_resources', ''); "
               "assert pkg_resources.resource_string('pkg_resources', '__init__.py'); "
               "assert pkg_resources.require('pkg_resources'); "
               "assert pkg_resources.get_default_cache()"]
        infra.run_cmd_on_host(self.builddir, cmd)
