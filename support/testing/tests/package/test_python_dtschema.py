from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Dtschema(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_DTSCHEMA=y
        """
    sample_scripts = ["tests/package/sample_python_dtschema.py"]
    timeout = 40
