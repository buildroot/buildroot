from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Httpx2(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_HTTPX2=y
        """
    sample_scripts = ["tests/package/sample_python_httpx2.py"]
    timeout = 30
