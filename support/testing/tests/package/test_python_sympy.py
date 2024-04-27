from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3SymPy(TestPythonPackageBase):
    __test__ = True

    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_SYMPY=y
        """
    sample_scripts = ["tests/package/sample_python_sympy.py"]
    timeout = 20
