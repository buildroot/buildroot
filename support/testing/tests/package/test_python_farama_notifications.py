from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3FaramaNotifications(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_FARAMA_NOTIFICATIONS=y
        """
    sample_scripts = ["tests/package/sample_python_farama_notifications.py"]
    timeout = 20
