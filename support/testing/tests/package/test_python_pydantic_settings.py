import os

from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3PydanticSettings(TestPythonPackageBase):
    __test__ = True
    config = """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_NEON=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_PYDANTIC_SETTINGS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    sample_scripts = ["tests/package/sample_python_pydantic_settings.py"]
    timeout = 30

    def login(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(
            arch="armv7", kernel="builtin", options=["-initrd", cpio_file]
        )
        self.emulator.login()

    def run_sample_scripts(self):
        """Run sample script while setting an environment variable"""
        for script in self.sample_scripts:
            cmd = (
                "api_key=ABCD1234 " + self.interpreter + " " + os.path.basename(script)
            )
            self.assertRunOk(cmd, timeout=self.timeout)
