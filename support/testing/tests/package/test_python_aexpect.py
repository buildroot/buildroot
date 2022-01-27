from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Aexpect(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_AEXPECT=y
        """
    sample_scripts = ["tests/package/sample_python_aexpect.py"]
    timeout = 30
