import os

import infra.basetest


class TestLess(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_LESS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute. This command also checks that
        # the "less" program is from the actual "less" package, rather
        # than the Busybox implementation (the Busybox "less" applet
        # does not recognize the "--version" option and would fail).
        self.assertRunOk("less --version")

        # We create a test file.
        ref_txt = "Hello Buildroot!"
        input_fname = "input.txt"
        self.assertRunOk(f"echo \'{ref_txt}\' > {input_fname}")

        # "less" is mainly an interactive user program and uses
        # terminal control characters. This test checks a basic "less"
        # invocation in which there is no user interaction. The
        # program is expected to give back the input data.
        output, exit_code = self.emulator.run(f"less -F {input_fname}")
        self.assertEqual(exit_code, 0)
        # "less" might insert a carriage-return ^M control character,
        # which will be converted to a new-line (by the
        # str.splitlines() in Emulator.run()). We check that our
        # reference text line is in the output (rather than only
        # testing output[0]).
        self.assertIn(ref_txt, output)

        # We redo about the same test, with "less" reading stdin this
        # time. We also use the "less -o log" option to log the output
        # into a file. We expect to see our reference text on stdout.
        output_fname = "output.txt"
        cmd = f"cat {input_fname} | less -F -o {output_fname}"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn(ref_txt, output)

        # The output file content which logged the output is also
        # expected to be the same as the input.
        self.assertRunOk(f"cmp {input_fname} {output_fname}")
