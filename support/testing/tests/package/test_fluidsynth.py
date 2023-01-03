import os

import infra.basetest


class TestFluidsynth(infra.basetest.BRTest):
    # infra.basetest.BASIC_TOOLCHAIN_CONFIG cannot be used as it is
    # armv5 and based on qemu versatilepb which is limited to 256MB of
    # RAM.  The test needs 1GB of RAM (larger initrd and soundfont is
    # loaded in memory).
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.15.86"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_AUBIO=y
        BR2_PACKAGE_FLUIDSYNTH=y
        BR2_PACKAGE_FLUIDSYNTH_LIBSNDFILE=y
        BR2_PACKAGE_FLUID_SOUNDFONT=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_MIDIUTIL=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
           # overlay to add helper test scripts
           infra.filepath("tests/package/test_fluidsynth/rootfs-overlay"))

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "1G", "-initrd", img])
        self.emulator.login()

        # Test the binary executes
        self.assertRunOk("fluidsynth --version")

        # Create a simple MIDI file programmatically
        self.assertRunOk("/root/gen_midi_file.py /tmp/output.mid")

        # Convert the MIDI file to a WAV file
        cmd = "fluidsynth"
        cmd += " -F /tmp/output.wav"
        cmd += " /usr/share/soundfonts/FluidR3_GM.sf2"
        cmd += " /tmp/output.mid"
        self.assertRunOk(cmd)

        # Extract notes in the WAV file with Aubio
        self.assertRunOk("aubionotes /tmp/output.wav > /tmp/notes.txt")

        # Check the extracted notes are the expected ones
        self.assertRunOk("/root/check_notes.py < /tmp/notes.txt")
