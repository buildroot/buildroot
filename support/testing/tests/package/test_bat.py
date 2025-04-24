import os
import infra.basetest


class TestBat(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
            """
            BR2_PACKAGE_BAT=y
            BR2_TARGET_ROOTFS_CPIO=y
            # BR2_TARGET_ROOTFS_TAR is not set
            """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the programs can execute
        self.assertRunOk("bat --version")
        self.assertRunOk("echo 'hello test' > test.txt")

        # Run bat and capture output
        output, exit_code = self.emulator.run("bat test.txt", timeout=10)
        self.assertEqual(exit_code, 0)
        self.assertIn("hello test", "\n".join(output))
