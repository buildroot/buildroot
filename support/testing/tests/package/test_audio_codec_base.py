import math
import os

import infra.basetest


class TestAudioCodecBase(infra.basetest.BRTest):
    """Common class to test an audio codec package.

    This base class builds a Buildroot system image containing the
    package enabled in its config, start the emulator, login to it. It
    prepares an input test WAV file containing a tone. This WAV file
    is encoded into a new output file in the native encoder format. It
    is then decoded to a new output WAV file. This final output WAV
    file is checked to contain the expected tone generated in the
    initial input WAV file. There is no specific check about file
    size, nor audio quality. The acceptance criteria is the
    recognition of the tone. Note: the tone generation is made with
    the Sox package, and the tone recognition is made with the Aubio
    package.

    Each test case that inherits from this class must have:
    __test__ = True  - to let nose2 know that it is a test case
    config           - defconfig fragment with the packages to run the test
    encode_test()    - the function that runs the encoder and produces an
                       encoded file.
    decode_test()    - the function that runs the decoder and produces a
                       decode file.
    """
    __test__ = False
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_AUBIO=y
        BR2_PACKAGE_SOX=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    input_file = "reference.wav"
    decoded_file = "decoded.wav"
    tone_freq = 440  # General Midi note A3

    def login(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

    def test_run(self):
        self.login()
        self.prepare_data()
        self.encode_test(self.input_file)
        self.decode_test(self.decoded_file)
        self.check_test()

    def prepare_data(self):
        # Generate a sinusoidal tone.
        cmd = "sox -V -r 48000 -n -b 16 -c 1 "
        cmd += self.input_file
        cmd += f" synth 3 sin {self.tone_freq} vol -10dB"
        self.assertRunOk(cmd)

    def encode_test(self, input_filename):
        msg = "method must be implemented in derived class"
        raise NotImplementedError(msg)

    def decode_test(self, output_filename):
        msg = "method must be implemented in derived class"
        raise NotImplementedError(msg)

    def note_from_freq(self, freq):
        """Return a note number from the input frequency in Hertz."""
        return round((12 * math.log(freq / 440) / math.log(2)) + 69)

    def check_test(self):
        expected_note = self.note_from_freq(self.tone_freq)
        out, ret = self.emulator.run(f"aubionotes {self.decoded_file}", timeout=20)
        self.assertEqual(ret, 0)
        note_found = False
        for line in out:
            values = line.split()
            if len(values) == 3:
                note = round(float(values[0]))
                if note == expected_note:
                    note_found = True
        self.assertTrue(note_found, "The expected note was not found")
