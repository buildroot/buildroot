from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3ServiceIdentity(TestPythonPackageBase):
    __test__ = True
    # Need to use a different toolchain than the default due to
    # python-cryptography using Rust (not available with uclibc)
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARMV5_EABI_GLIBC_STABLE=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_SERVICE_IDENTITY=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    sample_scripts = ["tests/package/sample_python_service_identity.py"]
    timeout = 30
