from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3NetworkmanagerGoi(TestPythonPackageBase):
    __test__ = True
    # Can't use TestPythonPackageBase.config because we need headers
    # >= 4.20 for network-manager, so we have to use the bleeding-edge
    # toolchain.
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARMV5_EABI_GLIBC_BLEEDING_EDGE=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_GOBJECT=y
        BR2_INIT_SYSTEMD=y
        BR2_PACKAGE_NETWORK_MANAGER=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    sample_scripts = ["tests/package/sample_python_networkmanager_goi.py"]

    timeout = 30
