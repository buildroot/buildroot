import os

import infra.basetest


class TestOptee(infra.basetest.BRTest):
    # A custom configuration is needed to enable OP-TEE support in the
    # Kernel. This config is inspired from:
    # configs/qemu_arm_vexpress_tz_defconfig
    uboot_fragment = \
        infra.filepath("tests/boot/test_optee_os/u-boot.fragment")
    config = \
        f"""
        BR2_arm=y
        BR2_cortex_a15=y
        BR2_ARM_FPU_VFPV3D16=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_ROOTFS_POST_BUILD_SCRIPT="board/qemu/arm-vexpress-tz/post-build.sh"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.73"
        BR2_LINUX_KERNEL_DEFCONFIG="vexpress"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="board/qemu/arm-vexpress-tz/linux.fragment"
        BR2_PACKAGE_OPTEE_EXAMPLES=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        BR2_TARGET_ROOTFS_CPIO_UIMAGE=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_ARM_TRUSTED_FIRMWARE=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_CUSTOM_VERSION=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_CUSTOM_VERSION_VALUE="v2.9"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_PLATFORM="qemu"
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_FIP=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_BL32_OPTEE=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_UBOOT_AS_BL33=y
        BR2_TARGET_ARM_TRUSTED_FIRMWARE_ADDITIONAL_VARIABLES="BL32_RAM_LOCATION=tdram"
        BR2_TARGET_OPTEE_OS=y
        BR2_TARGET_OPTEE_OS_NEEDS_DTC=y
        BR2_TARGET_OPTEE_OS_PLATFORM="vexpress-qemu_virt"
        BR2_TARGET_UBOOT=y
        BR2_TARGET_UBOOT_BUILD_SYSTEM_KCONFIG=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION_VALUE="2022.04"
        BR2_TARGET_UBOOT_BOARD_DEFCONFIG="qemu_arm"
        BR2_TARGET_UBOOT_CONFIG_FRAGMENT_FILES="{uboot_fragment}"
        """

    def test_run(self):
        # There is no Kernel nor rootfs image here. They will be
        # loaded by TFTP through the emulated network interface in
        # u-boot.
        bios = os.path.join(self.builddir, "images", "flash.bin")
        tftp_dir = os.path.join(self.builddir, "images")
        self.emulator.boot(arch="arm",
                           options=["-M", "virt,secure=on",
                                    "-d", "unimp",
                                    "-cpu", "cortex-a15",
                                    "-m", "1024M",
                                    "-netdev", f"user,id=vmnic,tftp={tftp_dir}",
                                    "-device", "virtio-net-device,netdev=vmnic",
                                    "-bios", bios])
        self.emulator.login()

        # Check the Kernel has OP-TEE messages
        self.assertRunOk("dmesg | grep -F optee:")

        # Check we have OP-TEE devices
        self.assertRunOk("ls -al /dev/tee*")

        # Run some OP-TEE examples
        examples = ["aes", "hello_world", "hotp", "random", "secure_storage"]
        for ex in examples:
            self.assertRunOk(f"optee_example_{ex}")
