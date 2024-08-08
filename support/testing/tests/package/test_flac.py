from tests.package.test_audio_codec_base import TestAudioCodecBase


class TestFlac(TestAudioCodecBase):
    __test__ = True
    config = TestAudioCodecBase.config + \
        """
        BR2_PACKAGE_FLAC=y
        """
    encoded_file = "encoded.flac"

    def encode_test(self, input_filename):
        cmd = "flac"
        cmd += f" -o {self.encoded_file} {input_filename}"
        self.assertRunOk(cmd)

    def decode_test(self, output_filename):
        cmd = "flac -d"
        cmd += f" -o {output_filename} {self.encoded_file}"
        self.assertRunOk(cmd)
