from tests.package.test_python import TestPythonPackageBase
import infra.basetest


class TestPythonTftpy(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_TFTPY=y
        """
    sample_scripts = ["tests/package/sample_python_tftpy.py"]


class TestHostPythonTftpy(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-tftpy"]

    def test_run(self):
        cmd = ["host/bin/python3", "-c", "import tftpy"]
        infra.run_cmd_on_host(self.builddir, cmd)
