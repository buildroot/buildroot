import os

import infra.basetest


class TestGhostscript(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_ghostscript/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_GHOSTSCRIPT=y
        BR2_PACKAGE_TESSERACT_OCR=y
        BR2_PACKAGE_TESSERACT_OCR_LANG_ENG=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("gs --version")

        doc_basename = "document"
        ps_file = doc_basename + ".ps"
        pgm_file = doc_basename + ".pgm"
        txt_file = doc_basename + ".txt"

        # Render a basic PostScript file to an image file.
        cmd = "gs -dSAFER -dBATCH -dNOPAUSE -sDEVICE=pgmraw -r150"
        cmd += f" -dTextAlphaBits=4 -sOutputFile='{pgm_file}' {ps_file}"
        self.assertRunOk(cmd)

        # Run text recognition on the image file.
        cmd = f"tesseract {pgm_file} {doc_basename}"
        self.assertRunOk(cmd, timeout=30)

        # Check we extracted the expected string from the input
        # PostScript file.
        cmd = f"cat {txt_file}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "Hello Buildroot!")
