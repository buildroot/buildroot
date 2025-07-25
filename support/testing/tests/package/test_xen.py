import os
import pexpect
import infra.basetest


class TestXenBase(infra.basetest.BRTest):
    """A class to test Xen for multiple architectures."""

    # We run only in the initramfs; this allows to use a single ramdisk image
    # for both the host and the guest.
    base_config = \
        """
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="support/testing/tests/package/test_xen/common/post-build.sh"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.9"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_XEN=y
        BR2_PACKAGE_XEN_HYPERVISOR=y
        BR2_PACKAGE_XEN_TOOLS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_UBOOT=y
        BR2_TARGET_UBOOT_BUILD_SYSTEM_KCONFIG=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION=y
        BR2_TARGET_UBOOT_CUSTOM_VERSION_VALUE="2025.01"
        BR2_TARGET_UBOOT_NEEDS_OPENSSL=y
        BR2_TARGET_UBOOT_NEEDS_GNUTLS=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_MTOOLS=y
        """

    def get_dom_uuid(self) -> str:
        out, rc = self.emulator.run("cat /sys/hypervisor/uuid")
        self.assertEqual(rc, 0, "Failed to get domain UUID")
        return out[0]

    def assertNumVM(self, x: int) -> None:
        out, rc = self.emulator.run("xl vm-list")
        self.assertEqual(rc, 0, "Failed to get VM list")
        num_vm = len(out) - 1
        self.assertEqual(num_vm, x, f"Expected {x} VM(s) but found {num_vm}")

    def run_xen_test(self, arch: str, options: list[str]) -> None:
        """This functions tests Xen for multiple architectures.
        The arch and options parameters are passed to the emulator.
        """

        # Boot the emulator.
        # The system should automatically boot Xen and a Dom0.
        self.emulator.boot(arch=arch, options=options)
        self.emulator.login()

        # Verify that we are indeed running under Xen.
        self.assertRunOk("xl info")

        # Check that we are dom0.
        uuid = self.get_dom_uuid()
        dom0_uuid = "00000000-0000-0000-0000-000000000000"
        self.assertEqual(uuid, dom0_uuid, f"Unexpected dom UUID {uuid}")

        # Check that we have one VM running.
        self.assertNumVM(1)

        # Create dom1 with console attached and login.
        self.emulator.qemu.sendline("xl create -c /etc/xen/dom1.cfg")
        self.emulator.login()

        # Check that we are not talking to dom0 anymore.
        uuid = self.get_dom_uuid()
        self.assertNotEqual(uuid, dom0_uuid, "Unexpected dom0 UUID")

        # Detach from dom1's console with CTRL-].
        # dom1 is still running in the background after that.
        self.emulator.qemu.send(chr(0x1d))
        mult = self.emulator.timeout_multiplier
        index = self.emulator.qemu.expect(["#", pexpect.TIMEOUT],
                                          timeout=2 * mult)
        self.assertEqual(index, 0, "Timeout exiting guest")

        # Check that we are talking to dom0 again.
        uuid = self.get_dom_uuid()
        self.assertEqual(uuid, dom0_uuid, f"Unexpected dom UUID {uuid}")

        # Check that we have two VMs running.
        self.assertNumVM(2)


class TestXenAarch64(TestXenBase):
    # Test Xen on 64b Arm.
    # Boot flow: Qemu Devicetree -> U-Boot -> Xen UEFI -> Linux
    # We need to boot Xen in UEFI to read xen.cfg.
    # We use U-Boot as our UEFI firmware.
    # We have a custom kernel config to reduce build time.
    # Our genimage.cfg is inspired from qemu_aarch64_ebbr_defconfig as we boot
    # Xen with UEFI.
    config = TestXenBase.base_config + \
        """
        BR2_aarch64=y
        BR2_ROOTFS_OVERLAY="support/testing/tests/package/test_xen/common/overlay \
                            support/testing/tests/package/test_xen/aarch64/overlay"
        BR2_ROOTFS_POST_IMAGE_SCRIPT="support/testing/tests/package/test_xen/aarch64/post-image.sh support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c support/testing/tests/package/test_xen/aarch64/genimage.cfg"
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="support/testing/tests/package/test_xen/aarch64/linux.config"
        BR2_TARGET_UBOOT_BOARD_DEFCONFIG="qemu_arm64"
        """

    def test_run(self):
        uboot_bin = os.path.join(self.builddir, "images", "u-boot.bin")
        disk_img = os.path.join(self.builddir, "images", "disk.img")

        # We need to run Qemu with virtualization to run Xen.
        qemu_opts = [
            "-bios", uboot_bin,
            "-cpu", "cortex-a53",
            "-device", "virtio-blk-device,drive=hd0",
            "-drive", f"file={disk_img},if=none,format=raw,id=hd0",
            "-m", "1G",
            "-machine", "virt,gic-version=3,virtualization=on,acpi=off",
            "-smp", "2"
        ]

        # Run Xen test.
        self.run_xen_test(arch="aarch64", options=qemu_opts)


class TestXenArmv7(TestXenBase):
    # Test Xen on 32b Arm v7.
    # Boot flow: Qemu Devicetree -> U-Boot -> Xen -> Linux
    # Xen does not boot with UEFI on 32-bit Arm v7.
    # We use U-Boot and a script to load the Dom0 images and amend the
    # Devicetree for Xen dynamically.
    # We have a custom kernel config to reduce build time.
    config = TestXenBase.base_config + \
        """
        BR2_arm=y
        BR2_cortex_a15=y
        BR2_ROOTFS_OVERLAY="support/testing/tests/package/test_xen/common/overlay \
                            support/testing/tests/package/test_xen/arm/overlay"
        BR2_ROOTFS_POST_IMAGE_SCRIPT="support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c support/testing/tests/package/test_xen/arm/genimage.cfg"
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="support/testing/tests/package/test_xen/arm/linux.config"
        BR2_TARGET_UBOOT_BOARD_DEFCONFIG="qemu_arm"
        BR2_PACKAGE_HOST_UBOOT_TOOLS=y
        BR2_PACKAGE_HOST_UBOOT_TOOLS_BOOT_SCRIPT=y
        BR2_PACKAGE_HOST_UBOOT_TOOLS_BOOT_SCRIPT_SOURCE="support/testing/tests/package/test_xen/arm/boot.cmd"
        """

    def test_run(self):
        uboot_bin = os.path.join(self.builddir, "images", "u-boot.bin")
        disk_img = os.path.join(self.builddir, "images", "disk.img")

        # We need to run Qemu with virtualization to run Xen.
        qemu_opts = [
            "-bios", uboot_bin,
            "-cpu", "cortex-a15",
            "-device", "virtio-blk-device,drive=hd0",
            "-drive", f"file={disk_img},if=none,format=raw,id=hd0",
            "-m", "1G",
            "-machine", "virt,virtualization=on,acpi=off",
            "-smp", "2"
        ]

        # Run Xen test.
        self.run_xen_test(arch="armv7", options=qemu_opts)
