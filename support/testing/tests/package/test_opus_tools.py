from tests.package.test_audio_codec_base import TestAudioCodecBase


class TestOpusTools(TestAudioCodecBase):
    __test__ = True
    config = TestAudioCodecBase.config + \
        """
        BR2_PACKAGE_OPUS_TOOLS=y
        """
    encoded_file = "encoded.opus"

    def encode_test(self, input_filename):
        cmd = f"opusenc {input_filename} {self.encoded_file}"
        self.assertRunOk(cmd)

    def decode_test(self, output_filename):
        cmd = f"opusdec {self.encoded_file} {output_filename}"
        self.assertRunOk(cmd)
