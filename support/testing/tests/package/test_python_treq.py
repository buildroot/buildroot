from tests.package.test_python import TestPythonPackageBase


class TestPythonTreq(TestPythonPackageBase):
    sample_scripts = ["tests/package/sample_python_treq.py"]

    def run_sample_scripts(self):
        cmd = self.interpreter + " sample_python_treq.py"
        output, exit_code = self.emulator.run(cmd, timeout=20)
        refuse_msgs = [1 for line in output if "Connection refused" in line]
        self.assertGreater(sum(refuse_msgs), 0)
        self.assertEqual(exit_code, 0)


class TestPythonPy3Treq(TestPythonTreq):
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
        BR2_PACKAGE_PYTHON_TREQ=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
