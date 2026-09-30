import os

import infra.basetest


class TestHarfbuzz(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_HARFBUZZ=y
        BR2_PACKAGE_LIBGLIB2=y
        BR2_PACKAGE_DEJAVU=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # The hb-shape utility needs a fond.
        font = "/usr/share/fonts/dejavu/DejaVuSans.ttf"

        # The library loads and the utility runs.
        self.assertRunOk("hb-shape --version")

        # Basic invocation with a font.
        cmd = f"hb-shape --no-positions {font} A"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "[A=0]")
