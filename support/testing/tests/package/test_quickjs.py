import os

import infra.basetest


class TestQuickJS(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_quickjs/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_QUICKJS=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check can print a message from the command line.
        msg = "Hello Buildroot!"
        js_expr = f"console.log(\"{msg}\");"
        cmd = f"qjs -e '{js_expr}'"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

        # We check we can exit with a specific code.
        exit_code = 123
        js_expr = f"std.exit({exit_code});"
        cmd = f"qjs --std -e '{js_expr}'"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, exit_code)
        self.assertEqual(len(out), 0)

        # We check we can do basic arithmetic.
        val1 = 1234
        val2 = 5678
        js_expr = f"console.log({val1} * {val2});"
        cmd = f"qjs -e '{js_expr}'"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected_result = val1 * val2
        self.assertEqual(int(out[0]), expected_result)

        # We check we can run a slightly more complex program and dump
        # the memory usage.
        self.assertRunOk("qjs -d --std mandel.js")
