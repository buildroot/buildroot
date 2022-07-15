import os

import infra.basetest


class TestMsrTools(infra.basetest.BRTest):
    config = \
        """
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.15.55"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86_64/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{}"
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_MSR_TOOLS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
              infra.filepath("tests/package/test_msr_tools/linux.config"))

    def test_run(self):
        kernel = os.path.join(self.builddir, "images", "bzImage")
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(
            arch="x86_64",
            kernel=kernel, kernel_cmdline=["console=ttyS0"],
            options=["-cpu", "Nehalem", "-m", "320", "-initrd", cpio_file]
        )
        self.emulator.login()

        # CPU ID.
        cmd = "cpuid"
        self.assertRunOk(cmd)

        # Write MSR.
        # We write to TSC_AUX.
        cmd = "wrmsr 0xc0000103 0x1234567812345678"
        self.assertRunOk(cmd)

        # Read MSR.
        # We read back the TSC_AUX and we verify that we read back the correct
        # value.
        cmd = "rdmsr 0xc0000103"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "1234567812345678")
