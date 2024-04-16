import os

import infra.basetest


class TestEdk2(infra.basetest.BRTest):
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_ROOTFS_POST_IMAGE_SCRIPT="board/qemu/aarch64-sbsa/assemble-flash-images support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c board/qemu/aarch64-sbsa/genimage.cfg"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.10.34"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="support/testing/tests/boot/test_edk2/linux.config"
        BR2_TARGET_EDK2=y
        BR2_TARGET_EDK2_PLATFORM_QEMU_SBSA=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_ARM64_EFI=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_CUSTOM_VERSION=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_CUSTOM_VERSION_VALUE="v2.9"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_PLATFORM="qemu_sbsa"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_FIP=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_MTOOLS=y
        """

    def test_run(self):
        hda = os.path.join(self.builddir, "images", "disk.img")
        flash0 = os.path.join(self.builddir, "images", "SBSA_FLASH0.fd")
        flash1 = os.path.join(self.builddir, "images", "SBSA_FLASH1.fd")
        self.emulator.boot(arch="aarch64",
                           options=["-M", "sbsa-ref",
                                    "-cpu", "cortex-a57",
                                    "-m", "512M",
                                    "-pflash", flash0,
                                    "-pflash", flash1,
                                    "-hda", hda])
        self.emulator.login()
