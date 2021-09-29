import os

import infra.basetest


class TestExecline(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_EXECLINE=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()

        output, exit_code = self.emulator.run("execlineb -c 'echo hello world'")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0].strip(), "hello world")
