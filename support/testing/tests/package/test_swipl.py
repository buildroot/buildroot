import os

import infra.basetest


class TestSWIPL(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_swipl/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_SWIPL=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check program executes.
        cmd = "swipl --version"
        self.assertRunOk(cmd)

        # Check swipl fails when goal is false.
        cmd = "swipl -g false"
        _, exit_code = self.emulator.run(cmd)
        self.assertNotEqual(exit_code, 0)

        # Test output.
        string = "Hello Buildroot !"
        cmd = f"swipl -g 'writeln(\"{string}\")' -t halt"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], string)

        # Check the swipl demo file works (ex: "sam" likes "pizza").
        cmd = "swipl -g '[swi(demo/likes)]' -g 'likes(sam,pizza)' -t halt"
        self.assertRunOk(cmd)

        # Run a more complex logic program (solve a sudoku).
        cmd = "swipl -g top -t halt /root/sudoku.pl"
        self.assertRunOk(cmd, timeout=10)
