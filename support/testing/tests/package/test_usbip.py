import os

import infra.basetest


class TestUsbIp(infra.basetest.BRTest):
    # A specific configuration is needed for testing usbip, to
    # enable USB 2.0 and USBIP support in the Kernel.
    linux_fragment = \
        infra.filepath("tests/package/test_usbip/linux-usbip.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.6"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{linux_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_EUDEV=y
        BR2_PACKAGE_HWDATA=y
        BR2_PACKAGE_HWDATA_USB_IDS=y
        BR2_PACKAGE_USBIP=y
        BR2_PACKAGE_USBUTILS=y
        BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        # We add a USB keyboard and mouse devices for the test.
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                                    "-initrd", img,
                                    "-device", "usb-ehci,id=ehci",
                                    "-device", "usb-kbd,bus=ehci.0",
                                    "-device", "usb-mouse,bus=ehci.0"])
        self.emulator.login()

        # We check the program can execute.
        self.assertRunOk("usbipd --version")

        # We check "lsusb" sees exactly one QEMU USB Keyboard.
        out, ret = self.emulator.run("lsusb")
        self.assertEqual(ret, 0)
        kbd_count = "\n".join(out).count("QEMU USB Keyboard")
        self.assertEqual(kbd_count, 1)

        # The daemon is not running yet. Listing remote devices is
        # expected to fail.
        _, ret = self.emulator.run("usbip list --remote=127.0.0.1")
        self.assertNotEqual(ret, 0)

        # We start the USBIP daemon.
        self.assertRunOk("usbipd -D")

        # The daemon is started. Listing remote devices is now
        # expected to succeed, but with an empty list (since we did
        # not exported any device yet).
        out, ret = self.emulator.run("usbip list --remote=127.0.0.1")
        self.assertEqual(ret, 0)
        self.assertIn("no exportable devices found", "\n".join(out))

        # We list the local devices seen by usbip. We check we can see
        # our local USB keyboard device in it.
        out, ret = self.emulator.run("usbip list --local")
        self.assertEqual(ret, 0)
        self.assertIn("busid 1-1", "\n".join(out))

        # We bind the first device (USB Keyboard)
        self.assertRunOk("usbip bind --busid=1-1")

        # We list the remote devices. We should see our exported
        # keyboard: we check we have the list header, and the device
        # ID in the output.
        out, ret = self.emulator.run("usbip list --remote=127.0.0.1")
        self.assertEqual(ret, 0)
        out_str = "\n".join(out)
        self.assertNotIn("no exportable devices found", out_str)
        self.assertIn("Exportable USB devices", out_str)
        self.assertIn("(0627:0001)", out_str)

        # We attach the keyboard. This should create a second USB
        # keyboard.
        self.assertRunOk("usbip attach --remote=127.0.0.1 --busid=1-1")

        # We check "lsusb" now sees exactly two QEMU USB Keyboards
        # (the original one, and a second one created by usbip).
        out, ret = self.emulator.run("lsusb")
        self.assertEqual(ret, 0)
        kbd_count = "\n".join(out).count("QEMU USB Keyboard")
        self.assertEqual(kbd_count, 2)
