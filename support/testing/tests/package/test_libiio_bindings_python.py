from tests.package.test_python import TestPythonPackageBase


class TestLibiioBindingsPython(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_LIBIIO=y
        BR2_PACKAGE_LIBIIO_BINDINGS_PYTHON=y
        """
    sample_scripts = ["tests/package/sample_libiio_bindings_python.py"]
    timeout = 10
