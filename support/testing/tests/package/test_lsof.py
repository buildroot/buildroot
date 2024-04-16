import os

import infra.basetest


class TestLsof(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_LSOF=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        test_file = "/tmp/this-is-a-test-file"

        # Check the program can execute
        self.assertRunOk("lsof -v")

        # Check a normal program invocation
        self.assertRunOk("lsof")

        # Check lsof fails if requested file is not opened
        _, exit_code = self.emulator.run("lsof {}".format(test_file))
        self.assertNotEqual(exit_code, 0)

        # Open the test file from the shell on descriptor 10
        self.assertRunOk("exec 10> {}".format(test_file))

        # Check that lsof now show the file
        output, exit_code = self.emulator.run("lsof {}".format(test_file))
        self.assertEqual(exit_code, 0)
        # output[0] is the lsof header line
        self.assertIn(test_file, output[1])
