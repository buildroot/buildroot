import os

import infra.basetest


class TestPv(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_PV=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can run.
        self.assertRunOk("pv --version")

        # We check that "pv" works like the "cat" command. We print a
        # message on its standard input and redirect its output to a
        # file. We also force the pv terminal width to 80, since
        # "infra.emulator" is setting a large width to prevent
        # line wrapping.
        msg = "Hello Buildroot!"
        out_file = "/tmp/out.txt"
        cmd = f"echo '{msg}' | pv -w80 > {out_file}"
        self.assertRunOk(cmd)

        # We check the pv output file contains exactly our message.
        cmd = f"cat {out_file}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

        # Finally, we check that "pv" correctly shows a progress
        # bar. We print few lines, one per second into "pv" setup in
        # line mode. We check the last pv status line contains the
        # correct count and a "100%" string that shows completion.
        lines = 5
        print_ln_cmd = f"( for X in $(seq {lines}) ; do echo $X ; sleep 1 ; done )"
        cmd = f"{print_ln_cmd} | pv -s{lines} -l -w80 > /dev/null"
        out, ret = self.emulator.run(cmd, timeout=10)
        self.assertEqual(ret, 0)
        # pv updates status may contain extra spaces, and is updated
        # with carriage return characters. We strip lines and filter
        # out empty remaining lines, to make sure we get the last
        # meaningful status line.
        pv_out = [ln.strip() for ln in out]
        pv_out = [ln for ln in pv_out if ln]
        last_line = pv_out[-1]
        self.assertTrue(last_line.startswith(str(lines)))
        self.assertTrue(last_line.endswith("100%"))
