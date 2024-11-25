from tests.package.test_audio_codec_base import TestAudioCodecBase


class TestLame(TestAudioCodecBase):
    __test__ = True
    config = TestAudioCodecBase.config + \
        """
        BR2_PACKAGE_LAME=y
        """
    encoded_file = "encoded.mp3"

    def encode_test(self, input_filename):
        cmd = "lame --quiet"
        cmd += f" {input_filename} {self.encoded_file}"
        self.assertRunOk(cmd)

    def decode_test(self, output_filename):
        cmd = "lame --quiet --decode"
        cmd += f" {self.encoded_file} {output_filename}"
        self.assertRunOk(cmd)
