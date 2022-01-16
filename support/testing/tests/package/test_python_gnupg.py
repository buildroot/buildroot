from tests.package.test_python import TestPythonPackageBase


class TestPythonPy2GnuPG(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON=y
        BR2_PACKAGE_PYTHON_GNUPG=y
        """
    sample_scripts = ["tests/package/sample_python_gnupg.py"]


class TestPythonPy3GnuPG(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_GNUPG=y
        """
    sample_scripts = ["tests/package/sample_python_gnupg.py"]
