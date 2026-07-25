import os
from math import factorial

import infra.basetest


class TestGuile(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_guile/rootfs-overlay")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_GENERATE_LOCALE="en_US.UTF-8"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.40"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_SYSTEM_ENABLE_NLS=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_GUILE=y
        """

    def guile_cmd(self, guile_expr):
        return f"guile -q -c '{guile_expr}'"

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "512M", "-initrd", img])
        self.emulator.login()

        # Guile needs a locale configured to work properly.
        self.assertRunOk("export LANG=en_US.UTF-8")

        # Check the program works.
        self.assertRunOk("guile --version")

        # Check a string output.
        string = "Hello Buildroot!"
        cmd = self.guile_cmd(f'(display "{string}")(newline)')
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], string)

        # Check the exit status works.
        code = 123
        cmd = self.guile_cmd(f"(exit {code})")
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, code)

        # Check basic artihmetic works.
        val1 = 123
        val2 = 456
        guile_expr = f'(display (* {val1} {val2}))(newline)'
        cmd = self.guile_cmd(guile_expr)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        expected_result = val1 * val2
        self.assertEqual(int(output[0]), expected_result)

        # Check we can call a Guile script. We disable auto
        # compilation to suppress compilation and cache messages.
        val = 12
        cmd = f"GUILE_AUTO_COMPILE=0 /root/fact.scm {val}"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        expected_result = factorial(val)
        self.assertEqual(int(output[0]), expected_result)
