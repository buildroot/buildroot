from tests.package.test_python import TestPythonPackageBase


class TestPythonHwdata(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_HWDATA=y
        """
    sample_scripts = ["tests/package/sample_python_hwdata.py"]
    timeout = 10
