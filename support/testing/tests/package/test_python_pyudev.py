from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3PyUdev(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_LIBUDEV_ZERO=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_PYUDEV=y
        """
    sample_scripts = ["tests/package/sample_python_pyudev.py"]
