import os

import infra.basetest


class TestStrace(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_STRACE=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("strace --version")

        test_file = "buildroot-strace-test.txt"
        test_file_mode = "0600"
        strace_log = "strace.log"

        # Create a test file.
        self.assertRunOk(f"touch {test_file}")

        # Run strace on a chmod
        cmd = f"strace -o {strace_log} chmod {test_file_mode} {test_file}"
        self.assertRunOk(cmd)

        # Check the strace log contain a call to chmod()
        expected_str = f"chmod(\"{test_file}\", {test_file_mode}) = 0"
        self.assertRunOk(f"grep -F '{expected_str}' {strace_log}")
