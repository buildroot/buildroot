from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Gymnasium(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_GYMNASIUM=y
        """
    sample_scripts = ["tests/package/sample_python_gymnasium.py"]
    timeout = 20
