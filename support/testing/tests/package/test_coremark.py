import os

import infra.basetest


class TestCoreMark(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_COREMARK=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        log_file = "run1.log"

        # Run a CoreMark benchmark.
        self.assertRunOk(f"coremark > {log_file}", timeout=60)

        # Print the log file on console, for debugging.
        self.assertRunOk(f"cat {log_file}")

        # The "coremark" program return code is always 0 (success).
        # So the correct execution is validated from the run log.
        valid_msg = "Correct operation validated."
        cmd = f"grep -F '{valid_msg}' {log_file}"
        self.assertRunOk(cmd)
