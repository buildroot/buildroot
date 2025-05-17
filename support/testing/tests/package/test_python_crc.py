from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Crc(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_CRC=y
        """
    sample_scripts = ["tests/package/sample_python_crc.py"]
