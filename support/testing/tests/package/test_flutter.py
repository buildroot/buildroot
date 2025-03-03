import os
import time
import infra.basetest

from ..graphics_base import GraphicsBase


class TestFlutter(infra.basetest.BRTest, GraphicsBase):
    config = f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_ROOTFS_OVERLAY="{infra.filepath("tests/package/test_flutter/overlay")}"
        BR2_PER_PACKAGE_DIRECTORIES=y
        BR2_INIT_SYSTEMD=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.54"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{infra.filepath("tests/package/test_flutter/linux-vkms.fragment")}"
        BR2_PACKAGE_LIBDRM=y
        BR2_PACKAGE_MESA3D=y
        BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_SWRAST=y
        BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_VIRGL=y
        BR2_PACKAGE_MESA3D_OPENGL_ES=y
        BR2_PACKAGE_FLUTTER_PI=y
        BR2_PACKAGE_FLUTTER_PI_RAW_KEYBOARD_PLUGIN=y
        BR2_PACKAGE_FLUTTER_PI_TEXT_INPUT_PLUGIN=y
        BR2_PACKAGE_FLUTTER_PACKAGES=y
        BR2_PACKAGE_FLUTTER_MARKDOWN_EXAMPLE=y
        BR2_PACKAGE_FLUTTER_ENGINE=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="512M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.ext2")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(
            arch="aarch64",
            kernel=kern,
            kernel_cmdline=["root=/dev/vda console=ttyAMA0 vt.global_cursor_default=0"],
            options=["-M", "virt",
                     "-cpu", "cortex-a57",
                     "-m", "512M",
                     "-smp", "4",
                     "-drive", f"file={img},if=virtio,format=raw"])
        self.emulator.login()

        # Get the CRC from the current ramebuffer
        empty_crc = self.get_n_fb_crc(count=1)[0]

        # Start the example App. It can take a bit of time to start,
        # so lets try a few times. 600 samples should cover about 10s
        # @60Hz (although, the rendering could be much slower on slow
        # machines)
        self.assertRunOk("systemctl start flutter-markdown-example", timeout=10)
        for i in range(600):
            gallery_crc = self.get_n_fb_crc(count=1)[0]
            if gallery_crc != empty_crc:
                break
            time.sleep(1)
        self.assertNotEqual(gallery_crc, empty_crc, "gallery app did not render anything on screen")

        # Stop the application, and check it restored the framebuffer content
        self.assertRunOk("systemctl stop flutter-markdown-example", timeout=10)
        for i in range(600):
            gallery_crc = self.get_n_fb_crc(count=1)[0]
            if gallery_crc == empty_crc:
                break
            time.sleep(1)
        self.assertEqual(gallery_crc, empty_crc, "gallery app did not stop rendering")
