import os

import infra.basetest


class TestGnuplot(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_gnuplot/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_GNUPLOT=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def gen_gnuplot_cmd(self, gpcmd):
        return f"gnuplot -e '{gpcmd}'"

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can run.
        self.assertRunOk("gnuplot --version")

        # When the locale is C, Gnuplot print the warning:
        # "line 0: warning: iconv failed to convert degree sign"
        # We set the locale to avoid this warning.
        self.assertRunOk('export LC_ALL="en_US.UTF-8"')

        # We check Gnuplot can print a string.
        string = "Hello Buildroot !"
        cmd = self.gen_gnuplot_cmd(f'print "{string}"')
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], string)

        # We check Gnuplot can do a simple arithmetic operation.
        op1 = 123
        op2 = 456
        expected_result = op1 * op2
        cmd = self.gen_gnuplot_cmd(f"print {op1} * {op2}")
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(int(out[0]), expected_result)

        # We check Gnuplot can return a specific exit code.
        exit_code = 123
        cmd = self.gen_gnuplot_cmd(f"exit status {exit_code}")
        _, ret = self.emulator.run(cmd)
        self.assertEqual(ret, exit_code)

        # We render a simple plot on the terminal.
        gpcmd = "set term dumb; set grid; plot [-5:5] x**2;"
        cmd = self.gen_gnuplot_cmd(gpcmd)
        self.assertRunOk(cmd)

        # We check a Gnuplot script executes correctly.
        cmd = "gnuplot /root/gnuplot-test.plot"
        self.assertRunOk(cmd)

        # Our Gnuplot script is supposed to have generated a text
        # output of the plot. We check this file contains the plot
        # title set in the script.
        exp_str = "Buildroot Test Plot"
        cmd = f"grep -Fo '{exp_str}' /root/gnuplot-test.txt"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], exp_str)
