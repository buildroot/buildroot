import os
import infra.basetest


class TestDust(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_DUST=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check that dust is installed and can be executed
        self.assertRunOk("dust --version")

        # Create a test directory structure with some files
        self.assertRunOk("mkdir -p testdir/subdir")
        self.assertRunOk("dd if=/dev/zero of=testdir/a bs=1K count=10")
        self.assertRunOk("dd if=/dev/zero of=testdir/subdir/b bs=1K count=5")

        # Run dust on the test directory and capture the output
        output, exit_code = self.emulator.run("dust testdir", timeout=10)
        self.assertEqual(exit_code, 0)
        self.assertIn("testdir", "\n".join(output))
        self.assertIn("subdir", "\n".join(output))
