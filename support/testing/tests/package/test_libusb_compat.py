import os

import infra.basetest


class TestLibusbCompat(infra.basetest.BRTest):
    # enable USB 2.0 support so we can test the USB enumeration in qemu
    linux_fragment = \
        infra.filepath("tests/package/test_libusb_compat/linux-usb.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.73"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{linux_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_LIBUSB=y
        BR2_PACKAGE_LIBUSB_COMPAT=y
        BR2_PACKAGE_LIBUSB_COMPAT_EXAMPLES=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    examples_dir = "/usr/libexec/libusb-compat/examples"

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        # We add a USB keyboard device for the test.
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                                    "-initrd", img,
                                    "-device", "usb-ehci,id=ehci",
                                    "-device", "usb-kbd,bus=ehci.0"])
        self.emulator.login()

        # The lsusb example prints "idVendor:idProduct" for every
        # device. We expect the Linux Foundation 2.0 root hub
        # (1d6b:0002) and the QEMU USB keyboard (0627:0001).
        output, exit_code = self.emulator.run(f"{self.examples_dir}/lsusb")
        self.assertEqual(exit_code, 0)
        self.assertIn("1d6b:0002", output)
        self.assertIn("0627:0001", output)

        # The testlibusb example opens every device and prints its
        # descriptors. The keyboard should show up as a HID
        # (bInterfaceClass 3) device.
        output, exit_code = self.emulator.run(f"{self.examples_dir}/testlibusb -v")
        self.assertEqual(exit_code, 0)
        self.assertIn("bInterfaceClass:    3", "\n".join(output))
