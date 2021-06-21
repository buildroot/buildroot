from tests.package.test_python import TestPythonPackageBase


class TestPythonAugeas(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_AUGEAS=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_AUGEAS=y
        """
    sample_scripts = ["tests/package/sample_python_augeas.py"]
    timeout = 60
