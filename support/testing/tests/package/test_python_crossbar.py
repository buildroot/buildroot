from tests.package.test_python import TestPythonPackageBase
import os


class TestPythonPy3Crossbar(TestPythonPackageBase):
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
        BR2_PACKAGE_PYTHON_CROSSBAR=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="120M"
        """
    sample_scripts = ["tests/package/sample_python_crossbar.py"]
    timeout = 60

    def login(self):
        ext2_file = os.path.join(self.builddir, "images", "rootfs.ext2")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-drive", "file=%s,if=scsi,format=raw" % ext2_file],
                           kernel_cmdline=["rootwait", "root=/dev/sda"])
        self.emulator.login()
