import math
import os

import infra.basetest


class TestSox(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_AUBIO=y
        BR2_PACKAGE_SOX=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def note_from_freq(self, freq):
        """Return a note number from the input frequency in Hertz."""
        return round((12 * math.log(freq / 440) / math.log(2)) + 69)

    def check_audio_note(self, input_file, expected_note):
        """Check the input_file include the expected_note."""
        out, ret = self.emulator.run(f"aubionotes {input_file}", timeout=20)
        self.assertEqual(ret, 0)
        note_found = False
        for line in out:
            values = line.split()
            if len(values) == 3:
                note = round(float(values[0]))
                if note == expected_note:
                    note_found = True
        self.assertTrue(note_found, "The expected note was not found")

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("sox --version")

        freq = 440  # General Midi note A3
        expected_note = self.note_from_freq(freq)
        wav_file = "ref.wav"
        tmpwav_file = "tmp.wav"

        # Generate a sinusoidal tone.
        cmd = "sox -V -r 48000 -n -b 16 -c 1"
        cmd += f" {wav_file} synth 3 sin {freq} vol -10dB"
        self.assertRunOk(cmd)

        # Compute statistics on the generated file.
        self.assertRunOk(f"sox {wav_file} -n stat")

        # We check the generated wave file includes the expected note.
        self.check_audio_note(wav_file, expected_note)

        # We resample the reference file.
        cmd = f"sox -V {wav_file} -r 22050 {tmpwav_file}"
        self.assertRunOk(cmd)

        # We should still detect our expected note.
        self.check_audio_note(tmpwav_file, expected_note)

        # We convert the file by changing the speed by a factor.
        speed_factor = 2
        cmd = f"sox -V {wav_file} {tmpwav_file} speed {speed_factor}"
        self.assertRunOk(cmd)

        # We compute the new expected note from this test controller
        # side, and check we detect this new note in the audio file.
        new_expected_note = self.note_from_freq(freq * speed_factor)
        self.check_audio_note(tmpwav_file, new_expected_note)
