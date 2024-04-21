import os
from math import sqrt

import infra.basetest


class Test4th(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_4TH=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We set the DIR4TH variable where 4th demos and libraries are
        # installed.
        self.assertRunOk("export DIR4TH=/usr/share/4th/")

        # We run a simple "hello world" demo.
        out, ret = self.emulator.run("4th cxq demo/hello.4th")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "Hello world!")

        # We run a demo doing some square root maths.
        out, ret = self.emulator.run("4th cxq demo/squares.4th")
        self.assertEqual(ret, 0)
        self.assertTrue(len(out) > 1)
        for line in out[1:]:
            columns = line.split()
            value = float(columns[0])
            value_sqrt = float(columns[1])
            result_check = sqrt(value)
            self.assertAlmostEqual(value_sqrt, result_check, delta=0.1)

        # We run a word count demo and the 4th source file. We save
        # the word count for a later check.
        out, ret = self.emulator.run("4th cxq wc.4th /usr/share/4th/wc.4th")
        self.assertEqual(ret, 0)
        wc_out = out[0].split()

        # We run the same command using system "wc" command. We expect
        # the same numbers.
        out, ret = self.emulator.run("wc /usr/share/4th/wc.4th")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0].split(), wc_out)

        # We run a slightly more complex computation example.
        self.assertRunOk("4th cxq fractals.4th")
