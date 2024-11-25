from tests.package.test_audio_codec_base import TestAudioCodecBase


class TestVorbisTools(TestAudioCodecBase):
    __test__ = True
    config = TestAudioCodecBase.config + \
        """
        BR2_PACKAGE_VORBIS_TOOLS=y
        """
    encoded_file = "encoded.ogg"

    def encode_test(self, input_filename):
        cmd = "oggenc"
        cmd += f" -o {self.encoded_file} {input_filename}"
        self.assertRunOk(cmd)

    def decode_test(self, output_filename):
        cmd = "oggdec"
        cmd += f" -o {output_filename} {self.encoded_file}"
        self.assertRunOk(cmd)
