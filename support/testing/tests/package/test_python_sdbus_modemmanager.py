from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3SdbusNetworkmanager(TestPythonPackageBase):
    __test__ = True
    config = (
        TestPythonPackageBase.config
        + """
        BR2_PACKAGE_PYTHON3=y
        BR2_INIT_SYSTEMD=y
        BR2_PACKAGE_MODEM_MANAGER=y
        BR2_PACKAGE_PYTHON_SDBUS_MODEMMANAGER=y
        """
    )
    sample_scripts = ["tests/package/sample_python_sdbus_modemmanager.py"]
