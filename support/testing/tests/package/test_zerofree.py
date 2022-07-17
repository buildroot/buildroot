import os
import infra.basetest
import subprocess


class TestZerofree(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ZEROFREE=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        # Prepare disk image.
        # We keep it small (8 MB) for the sake of test time.
        disk_file = os.path.join(self.outputdir, "disk.img")
        subprocess.check_call(
            ["dd", "if=/dev/zero", f"of={disk_file}", "bs=1M", "count=8"],
            stdout=self.emulator.logfile,
            stderr=self.emulator.logfile)

        # Run the emulator with a drive.
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=[
                                "-initrd", cpio_file,
                                "-drive", f"file={disk_file},format=raw"])
        self.emulator.login()

        # Prepare filesystem.
        output, exit_code = self.emulator.run("mkfs.ext4 /dev/sda")
        self.assertEqual(exit_code, 0)
        self.assertIn('Creating filesystem', output[2])

        # Run zerofree on newly created filesystem.
        cmd = "zerofree -v /dev/sda"
        output, exit_code = self.emulator.run(cmd, timeout=60)
        self.assertEqual(exit_code, 0)
        self.assertIn('/8192', output[-1])  # total number of blocks
