from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3MlDtypes(TestPythonPackageBase):
    __test__ = True

    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_ML_DTYPES=y
        """
    sample_scripts = ["tests/package/sample_python_ml_dtypes.py"]
    timeout = 20
