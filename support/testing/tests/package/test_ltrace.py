import os

import infra.basetest


class TestLtrace(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LTRACE=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute
        self.assertRunOk("ltrace --version")

        # Run ltrace on a ls
        cmd = "ltrace -a 0 -o ltrace.log ls /"
        self.assertRunOk(cmd)

        # Check the ltrace log contains occurrences of libc malloc()
        cmd = "grep -Ec 'malloc\\([0-9]+\\)' ltrace.log"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertGreater(int(out[0]), 0)
