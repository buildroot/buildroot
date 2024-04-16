from tests.package.test_python import TestPythonPackageBase
import os


class TestPythonPy3Botocore(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_BOTOCORE=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="250M"
        """
    sample_scripts = ["tests/package/sample_python_botocore.py"]
    timeout = 30

    def login(self):
        ext2_file = os.path.join(self.builddir, "images", "rootfs.ext2")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-drive", "file=%s,if=scsi,format=raw" % ext2_file],
                           kernel_cmdline=["rootwait", "root=/dev/sda"])
        self.emulator.login()
