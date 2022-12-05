import os

import infra.basetest


class TestZ3(infra.basetest.BRTest):
    # Need to use a different toolchain than the default due to
    # z3 requiring fenv.h not provided by uclibc.
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARMV5_EABI_GLIBC_STABLE=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_Z3=y
        BR2_PACKAGE_Z3_PYTHON=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
           # overlay to add a z3 smt and python test scripts
           infra.filepath("tests/package/test_z3/rootfs-overlay"))

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check program executes
        cmd = "z3 --version"
        self.assertRunOk(cmd)

        # Run a basic smt2 example
        cmd = "z3 /root/z3test.smt2"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "unsat")

        # Run a basic python example
        cmd = "/root/z3test.py"
        self.assertRunOk(cmd, timeout=10)
