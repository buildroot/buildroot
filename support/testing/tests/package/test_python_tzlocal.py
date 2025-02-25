from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3TZLocal(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_TARGET_TZ_INFO=y
        BR2_TARGET_LOCALTIME="Europe/Berlin"
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_TZLOCAL=y
        """
    sample_scripts = ["tests/package/sample_python_tzlocal.py"]
    timeout = 10
