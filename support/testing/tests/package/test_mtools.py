import os

import infra.basetest


class TestMtools(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_MTOOLS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        dos_img = "dos-fat.img"
        mtools_opts = f"-i {dos_img}"

        self.assertRunOk("mtools --version")

        # Create an empty image file to hold the FAT partition
        self.assertRunOk(f"dd if=/dev/zero of={dos_img} bs=1M count=1")

        # Any Mtools command is expected to fail on an unformatted
        # partition.
        cmd = f"minfo {mtools_opts} ::"
        _, exit_code = self.emulator.run(cmd)
        self.assertNotEqual(exit_code, 0)

        # Now, let's format the partition file to FAT
        self.assertRunOk(f"mformat {mtools_opts} ::")

        # Run some Mtools commands on this empty partition
        self.assertRunOk(f"minfo {mtools_opts} ::")
        self.assertRunOk(f"mdir {mtools_opts} ::")
        self.assertRunOk(f"mlabel {mtools_opts} -N 12345678 ::BUILDROOT")

        # Create a reference file on our Linux filesystem
        self.assertRunOk("echo 'Hello Buildroot!' > file1.txt")

        # Copy the reference file into the DOS image, then perform
        # various file manipulations
        self.assertRunOk(f"mcopy {mtools_opts} file1.txt ::file2.txt")
        self.assertRunOk(f"mcopy {mtools_opts} ::file2.txt ::file3.txt")
        self.assertRunOk(f"mdel {mtools_opts} ::file2.txt")
        self.assertRunOk(f"mren {mtools_opts} ::file3.txt ::file4.txt")
        self.assertRunOk(f"mmd {mtools_opts} ::dir1")
        self.assertRunOk(f"mmove {mtools_opts} ::file4.txt ::dir1")
        self.assertRunOk(f"mdir {mtools_opts} ::dir1")
        self.assertRunOk(f"mdu {mtools_opts} -a ::")

        # Copy back the file from the DOS image to the Linux
        # filesystem
        self.assertRunOk(f"mcopy {mtools_opts} ::dir1/file4.txt file5.txt")

        # We expect this last copied file to have the same content as
        # the reference one created at the beginning
        self.assertRunOk("cmp file1.txt file5.txt")

        # Delete a directory tree containing a file
        self.assertRunOk(f"mdeltree {mtools_opts} ::dir1")
