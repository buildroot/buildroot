import os

import infra.basetest


class TestOpenOCD(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_OPENOCD=y
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
        self.assertRunOk("openocd --version")

        msg = "Buildroot"

        # We check openocd can run, load a "dummy" driver in the
        # standard search path, and use some of its TCL commands. See:
        # https://github.com/openocd-org/openocd/blob/v0.12.0/doc/manual/primer/commands.txt#L117
        # https://github.com/openocd-org/openocd/blob/v0.12.0/src/jtag/drivers/dummy.c
        cmd = "openocd"
        cmd += " -f interface/dummy.cfg"
        cmd += f" -c 'dummy hello {msg}'"
        cmd += " -c shutdown"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected_str = f"Greetings {msg}!"
        self.assertIn(expected_str, out)
