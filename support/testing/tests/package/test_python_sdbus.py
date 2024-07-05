from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Sdbus(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_INIT_SYSTEMD=y
        BR2_PACKAGE_PYTHON_SDBUS=y
        """
    sample_scripts = ["tests/package/sample_python_sdbus.py"]
