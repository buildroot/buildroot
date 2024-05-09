import os

import infra.basetest


class TestZbar(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_IMAGEMAGICK=y
        BR2_PACKAGE_LIBQRENCODE=y
        BR2_PACKAGE_LIBQRENCODE_TOOLS=y
        BR2_PACKAGE_ZBAR=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        txt_msg = "Hello Buildroot!"
        qr_img = "qr.png"

        # We check the program can execute.
        self.assertRunOk("zbarimg --version")

        # We generate a QR code image containing a message.
        self.assertRunOk(f"qrencode -o '{qr_img}' '{txt_msg}'")

        # We decode the QR code image and check the extracted message
        # is the expected one.
        out, ret = self.emulator.run(f"zbarimg -q --raw {qr_img}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], txt_msg)
