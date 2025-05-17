from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Apscheduler(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_APSCHEDULER=y
        """
    sample_scripts = ["tests/package/sample_python_apscheduler.py"]
    timeout = 15
