from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Boto3(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_BOTO3=y
        """
    sample_scripts = ["tests/package/sample_python_boto3.py"]
    timeout = 10
