import os

import infra.basetest


class TestEdk2(infra.basetest.BRTest):
    config = \
        """
        BR2_aarch64=y
        BR2_neoverse_n1=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_ROOTFS_POST_IMAGE_SCRIPT="board/qemu/aarch64-sbsa/assemble-flash-images support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c board/qemu/aarch64-sbsa/genimage.cfg"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.58"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="support/testing/tests/boot/test_edk2/linux.config"
        BR2_TARGET_EDK2=y
        BR2_TARGET_EDK2_PLATFORM_QEMU_SBSA=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_ARM64_EFI=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_CUSTOM_VERSION=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_CUSTOM_VERSION_VALUE="v2.12"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_PLATFORM="qemu_sbsa"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_FIP=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_MTOOLS=y
        BR2_PACKAGE_HOST_QEMU=y
        BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=y
        """

    def test_run(self):
        hda = os.path.join(self.builddir, "images", "disk.img")
        flash0 = os.path.join(self.builddir, "images", "SBSA_FLASH0.fd")
        flash1 = os.path.join(self.builddir, "images", "SBSA_FLASH1.fd")
        self.emulator.boot(arch="aarch64",
                           options=["-M", "sbsa-ref",
                                    "-cpu", "neoverse-n1",
                                    "-m", "512M",
                                    "-pflash", flash0,
                                    "-pflash", flash1,
                                    "-hda", hda])
        self.emulator.login()


class TestEdk2BuildBase(infra.basetest.BRTest):
    """A class to test the build of various edk2 platforms."""
    base_config = \
        """
        # BR2_PACKAGE_BUSYBOX is not set
        # BR2_PACKAGE_IFUPDOWN_SCRIPTS is not set
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_INIT_NONE=y
        BR2_SYSTEM_BIN_SH_NONE=y
        BR2_TARGET_EDK2=y
        BR2_TOOLCHAIN_EXTERNAL=y
        """

    def assertBinariesExist(self, *binaries: str) -> None:
        """Assert that the binaries passed as argument exist
        under the images folder.
        We print a message to the emulator logfile for each binary found.
        """
        for binary in binaries:
            binpath = os.path.join(self.builddir, "images", binary)
            self.assertTrue(os.path.exists(binpath), f"Missing {binpath}!")
            print(f"{binary} exists: {binpath}", file=self.emulator.logfile,
                  flush=True)


class TestEdk2BuildArmVirtQemu(TestEdk2BuildBase):
    config = TestEdk2BuildBase.base_config + \
        """
        BR2_aarch64=y
        BR2_TARGET_EDK2_PLATFORM_ARM_VIRT_QEMU=y
        """

    def test_run(self) -> None:
        self.assertBinariesExist("QEMU_EFI.fd", "QEMU_VARS.fd")


class TestEdk2BuildArmVirtQemuKernel(TestEdk2BuildBase):
    config = TestEdk2BuildBase.base_config + \
        """
        BR2_aarch64=y
        BR2_TARGET_EDK2_PLATFORM_ARM_VIRT_QEMU_KERNEL=y
        """

    def test_run(self) -> None:
        self.assertBinariesExist("QEMU_EFI.fd", "QEMU_VARS.fd")


class TestEdk2BuildArmSgi575(TestEdk2BuildBase):
    config = TestEdk2BuildBase.base_config + \
        """
        BR2_aarch64=y
        BR2_TARGET_EDK2_PLATFORM_ARM_SGI575=y
        """

    def test_run(self) -> None:
        self.assertBinariesExist("BL33_AP_UEFI.fd")


class TestEdk2BuildArmVexpressFvpAarch64(TestEdk2BuildBase):
    config = TestEdk2BuildBase.base_config + \
        """
        BR2_aarch64=y
        BR2_TARGET_EDK2_PLATFORM_ARM_VEXPRESS_FVP_AARCH64=y
        """

    def test_run(self) -> None:
        self.assertBinariesExist("FVP_AARCH64_EFI.fd")


class TestEdk2BuildSocionextDeveloperbox(TestEdk2BuildBase):
    config = TestEdk2BuildBase.base_config + \
        """
        BR2_aarch64=y
        BR2_TARGET_EDK2_PLATFORM_SOCIONEXT_DEVELOPERBOX=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_PLATFORM="synquacer"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_BL31=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_ADDITIONAL_TARGETS="PRELOADED_BL33_BASE=0x8200000"
        """

    def test_run(self) -> None:
        self.assertBinariesExist("SPI_NOR_IMAGE.fd", "fip.bin")


class TestEdk2BuildQemuSbsa(TestEdk2BuildBase):
    # This configuration is not exactly identical to the configuration built
    # during TestEdk2, as we use the latest arm-trusted-firmware version, among
    # other things.
    config = TestEdk2BuildBase.base_config + \
        """
        BR2_aarch64=y
        BR2_TARGET_EDK2_PLATFORM_QEMU_SBSA=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_PLATFORM="qemu_sbsa"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_FIP=y
        """

    def test_run(self) -> None:
        self.assertBinariesExist("SBSA_FLASH0.fd", "SBSA_FLASH1.fd", "fip.bin")


class TestEdk2BuildSolidrunArmada80x0mcbin(TestEdk2BuildBase):
    config = TestEdk2BuildBase.base_config + \
        """
        BR2_aarch64=y
        BR2_cortex_a72=y
        BR2_TARGET_EDK2_PLATFORM_SOLIDRUN_ARMADA80X0MCBIN=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_PLATFORM="a80x0_mcbin"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_EDK2_AS_BL33=y
        BR2_TARGET_BINARIES_MARVELL=y
        BR2_TARGET_MV_DDR_MARVELL=y
        """

    def test_run(self) -> None:
        self.assertBinariesExist("ARMADA_EFI.fd", "fip.bin", "ble.bin",
                                 "scp-fw.bin")
