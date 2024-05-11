from tests.package.test_python import TestPythonPackageBase


class TestPythonHid(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_HID=y
        """
    sample_scripts = ["tests/package/sample_python_hid.py"]
