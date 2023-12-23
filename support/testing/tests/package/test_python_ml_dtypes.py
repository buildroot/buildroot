from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3MlDtypes(TestPythonPackageBase):
    __test__ = True

    # Note: BR2_PACKAGE_PYTHON3_ZLIB=y is needed as a runtime
    # dependency because the Bootlin toolchain used for this test is
    # tainted with zlib (and gets detected by python3/numpy).
    # See commit 8ce33fed "package/gdb: gdbserver does not need zlib".
    # This config entry can be removed as soon as the toolchain is
    # updated without zlib in its sysroot.
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON3_ZLIB=y
        BR2_PACKAGE_PYTHON_ML_DTYPES=y
        """
    sample_scripts = ["tests/package/sample_python_ml_dtypes.py"]
    timeout = 20
