import os
import infra.basetest


class TestXen(infra.basetest.BRTest):
    # We have a custom kernel config to reduce build time.
    # Our genimage.cfg is inspired from qemu_aarch64_ebbr_defconfig as we boot
    # Xen with UEFI.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_ROOTFS_POST_IMAGE_SCRIPT="support/testing/tests/package/test_xen/post-image.sh support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c support/testing/tests/package/test_xen/genimage.cfg"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.9"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="support/testing/tests/package/test_xen/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_XEN=y
        BR2_PACKAGE_XEN_HYPERVISOR=y
        BR2_PACKAGE_XEN_TOOLS=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="128M"
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_UBOOT=y
        BR2_TARGET_UBOOT_BUILD_SYSTEM_KCONFIG=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION_VALUE="2025.01"
        BR2_TARGET_UBOOT_BOARD_DEFCONFIG="qemu_arm64"
        BR2_TARGET_UBOOT_NEEDS_OPENSSL=y
        BR2_TARGET_UBOOT_NEEDS_GNUTLS=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_MTOOLS=y
        """

    def test_run(self):
        uboot_bin = os.path.join(self.builddir, "images", "u-boot.bin")
        disk_img = os.path.join(self.builddir, "images", "disk.img")

        qemu_opts = [
            "-bios", uboot_bin,
            "-cpu", "cortex-a53",
            "-device", "virtio-blk-device,drive=hd0",
            "-drive", f"file={disk_img},if=none,format=raw,id=hd0",
            "-m", "2G",
            "-machine", "virt,gic-version=3,virtualization=on,acpi=off",
            "-smp", "2"
        ]

        # Boot the emulator:
        # Qemu Devicetree -> U-Boot -> Xen UEFI -> Linux
        self.emulator.boot(arch="aarch64",
                           options=qemu_opts)
        self.emulator.login()

        # Avoid double-cooking the terminal, otherwise the test infrastructure
        # would not be able to retrieve e.g. return codes properly.
        self.assertRunOk("stty raw")

        # Verify that we are indeed running under Xen.
        self.assertRunOk("xl info")
