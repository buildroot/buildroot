import os

import infra.basetest


class TestGstreamer1(infra.basetest.BRTest):
    # This test creates a full, yet simple, Gstreamer pipeline which
    # encodes/decodes a video, using only plugins from Base and Good
    # packages. It will use Tesseract OCR to validate the final
    # output. The DejaVu font package is also installed, in order to
    # have few fonts for the Pango plugin.
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_DEJAVU=y
        BR2_PACKAGE_GSTREAMER1=y
        BR2_PACKAGE_GST1_PLUGINS_BASE=y
        BR2_PACKAGE_GST1_PLUGINS_BASE_PLUGIN_OGG=y
        BR2_PACKAGE_GST1_PLUGINS_BASE_PLUGIN_PANGO=y
        BR2_PACKAGE_GST1_PLUGINS_BASE_PLUGIN_THEORA=y
        BR2_PACKAGE_GST1_PLUGINS_BASE_PLUGIN_VIDEOTESTSRC=y
        BR2_PACKAGE_GST1_PLUGINS_GOOD=y
        BR2_PACKAGE_GST1_PLUGINS_GOOD_PNG=y
        BR2_PACKAGE_GST1_PLUGINS_GOOD_PLUGIN_MULTIFILE=y
        BR2_PACKAGE_TESSERACT_OCR=y
        BR2_PACKAGE_TESSERACT_OCR_LANG_ENG=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        video_file = "videotest.ogg"
        num_frames = 10
        msg_prefix = "Hello Buildroot:"

        # We check the main program can execute.
        self.assertRunOk("gst-launch-1.0 --version")

        # We check we can list installed plugins.
        self.assertRunOk("gst-inspect-1.0")

        # We check we can query one of the plugin we requested.
        self.assertRunOk("gst-inspect-1.0 theoraenc")

        # We create a Ogg/Theora video file. We use the "videotestsrc"
        # with the ball animation which will create a small file. We
        # add a time overlay with a message. We encode with the Theora
        # codec and store everything in an Ogg container file.
        enc_pipeline = \
            f"videotestsrc num-buffers={num_frames} pattern=ball ! " \
            f"timeoverlay text=\"{msg_prefix}\" font-desc=\"Sans, 24\" ! " \
            f"theoraenc ! oggmux ! filesink location={video_file}"
        cmd = f"gst-launch-1.0 -v {enc_pipeline}"
        self.assertRunOk(cmd, timeout=15)

        # We decode our previous video file and store each frame in a
        # PNG image file.
        dec_pipeline = \
            f"filesrc location={video_file} ! " \
            "decodebin ! videoconvert ! pngenc ! " \
            "multifilesink index=1 location=frame%02d.png"
        cmd = f"gst-launch-1.0 -v {dec_pipeline}"
        self.assertRunOk(cmd)

        # We extract the text from our last image.
        img_file = f"frame{num_frames}.png"
        cmd = f"tesseract {img_file} output"
        self.assertRunOk(cmd)

        # We check we have our initial message.
        out, ret = self.emulator.run("cat output.txt")
        self.assertEqual(ret, 0)
        self.assertTrue(out[0].startswith(msg_prefix))
