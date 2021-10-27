from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Botocore(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_BOTOCORE=y
        """
    sample_scripts = ["tests/package/sample_python_botocore.py"]
    timeout = 10
