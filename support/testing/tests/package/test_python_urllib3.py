from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Urllib3(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_URLLIB3=y
        """
    sample_scripts = ["tests/package/sample_python_urllib3.py"]
    timeout = 20
