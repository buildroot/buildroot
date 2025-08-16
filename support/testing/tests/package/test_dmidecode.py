import os

import infra.basetest


class TestDmidecode(infra.basetest.BRTest):
    # We use a x86_64 arch for this dmidecode test because aarch64
    # SMBIOS is not supported in non-UEFI use-cases (and using a UEFI
    # aarch64 would make the test longer).
    config = \
        """
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.102"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86_64/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_DMIDECODE=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):

        # An arbitrary SMBIOS OEM string for the test
        oem_string = "Hello Buildroot SMBIOS"

        kernel = os.path.join(self.builddir, "images", "bzImage")
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        self.emulator.boot(
            arch="x86_64",
            kernel=kernel,
            kernel_cmdline=["console=ttyS0"],
            options=["-cpu", "Nehalem", "-m", "256", "-initrd", cpio_file,
                     "-smbios", f"type=11,value={oem_string}"],
        )
        self.emulator.login()

        # Check the program can run
        cmd = "dmidecode --version"
        self.assertRunOk(cmd)

        # Check a simple invocation of "dmidecode"
        self.assertRunOk("dmidecode")

        # Check a simple invocation of "biosdecode"
        self.assertRunOk("biosdecode")

        # Check dmidecode detects SMBIOS
        cmd = "dmidecode | grep -E '^SMBIOS .* present\\.$'"
        self.assertRunOk(cmd)

        # Check the system-manufacturer is QEMU
        cmd = "dmidecode -s system-manufacturer"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "QEMU")

        # Check we read back our OEM string
        cmd = "dmidecode --oem-string 1"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], oem_string)
