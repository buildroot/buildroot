import math
import os

import infra.basetest


class TestTcl(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_TCL=y
        # BR2_PACKAGE_TCL_SHLIB_ONLY is not set
        BR2_ROOTFS_OVERLAY="{infra.filepath("tests/package/test_tcl/rootfs-overlay")}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Print tcl the interpreter version and patchlevel.
        tcl_cmds = "puts \"tcl_version: $tcl_version\";"
        tcl_cmds += "puts \"patchlevel: [info patchlevel]\";"
        tcl_cmds += "exit 0"
        cmd = f"echo '{tcl_cmds}' | tclsh"
        self.assertRunOk(cmd)

        # We check tclsh correctly print a string.
        txt = "Hello Buildroot"
        cmd = f"echo 'puts \"{txt}\"; exit 0' | tclsh"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], txt)

        # We check tclsh can return a non-zero exit code.
        expected_code = 123
        cmd = f"echo 'exit {expected_code}' | tclsh"
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, expected_code)

        # We check a tcl program computing factorial run correctly.
        input_value = 12
        expected_output = str(math.factorial(input_value))
        cmd = f"/root/factorial.tcl {input_value}"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], expected_output)
