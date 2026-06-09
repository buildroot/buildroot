from tests.package.test_python import TestPythonPackageBase


class TestPythonLibyang(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON3_PYEXPAT=y
        BR2_PACKAGE_PYTHON_LIBYANG=y
        """
    sample_scripts = ["tests/package/sample_python_libyang.py"]
