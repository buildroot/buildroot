import os

import infra.basetest


class TestErlang(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ERLANG=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can execute.
        self.assertRunOk("erl -version")

        # We check can print a message from the command line.
        msg = "Hello Buildroot!"
        erl_expr = f"io:format(\"{msg}~n\"), halt()."
        cmd = f"erl -noshell -eval '{erl_expr}'"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

        # We check we can exit with a specific code.
        exit_code = 123
        erl_expr = f"halt({exit_code})."
        cmd = f"erl -noshell -eval '{erl_expr}'"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, exit_code)
        self.assertEqual(len(out), 0)

        # We check we can do basic arithmetic.
        val1 = 1234
        val2 = 5678
        erl_expr = f"X = {val1} * {val2}, io:format(\"~p~n\", [X]), halt()."
        cmd = f"erl -noshell -eval '{erl_expr}'"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected_result = val1 * val2
        self.assertEqual(int(out[0]), expected_result)
