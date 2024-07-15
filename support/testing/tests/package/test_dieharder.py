import os

import infra.basetest


class TestDieharder(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_DIEHARDER=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can run (by showing its version)
        self.assertRunOk("dieharder -V")

        # The birthdays randomness test on the mt19937 random number
        # generator with 25 sample is expected to always succeed.
        cmd = "dieharder -g mt19937 -d diehard_birthdays -t 25"
        output, exit_code = self.emulator.run(cmd, timeout=10)
        self.assertEqual(exit_code, 0)
        self.assertIn("PASSED", '\n'.join(output))

        # The birthdays randomness test on file /dev/zero is expected
        # to always fail.
        cmd = "dieharder -g file_input_raw -f /dev/zero -d diehard_birthdays -t 25"
        output, exit_code = self.emulator.run(cmd, timeout=40)
        self.assertEqual(exit_code, 0)
        self.assertIn("FAILED", '\n'.join(output))
