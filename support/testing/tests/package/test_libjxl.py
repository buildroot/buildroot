import os

import infra.basetest


class TestLibJXL(infra.basetest.BRTest):
    # infra.basetest.BASIC_TOOLCHAIN_CONFIG is not used as it is armv5
    # and the image encoding would take too long (several minutes).
    # We also add GraphicsMagick to generate and compare images for
    # the test.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.15.79"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_GRAPHICSMAGICK=y
        BR2_PACKAGE_LIBJXL=y
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M", "-initrd", img])
        self.emulator.login()

        ref = "/var/tmp/reference.ppm"
        jxl = "/var/tmp/encoded.jxl"
        dec = "/var/tmp/decoded.ppm"

        cmd = "gm convert IMAGE:LOGO {}".format(ref)
        self.assertRunOk(cmd)

        cmd = "cjxl {} {}".format(ref, jxl)
        self.assertRunOk(cmd, timeout=30)

        cmd = "djxl {} {}".format(jxl, dec)
        self.assertRunOk(cmd)

        cmd = "gm compare -metric mse -maximum-error 1e-3 {} {}".format(
            ref, dec)
        self.assertRunOk(cmd)
