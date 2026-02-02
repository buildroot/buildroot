import os
from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Requests(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_REQUESTS=y
        """
    sample_scripts = ["tests/package/sample_python_requests.py"]
    timeout = 15

    def login(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()
        self.assertRunOk("python3 -m http.server 80 &")
