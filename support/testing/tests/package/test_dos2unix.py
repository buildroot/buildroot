import os

import infra.basetest


class TestDos2Unix(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_DOS2UNIX=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can run. This test also checks that we're
        # using the real "dos2unix" rather than the applet provided in
        # BusyBox, since the "--version" option is recognized by the
        # real dos2unix and return an error in BusyBox.
        self.assertRunOk("dos2unix --version")

        # Create a text file with UNIX new-lines
        self.assertRunOk("echo -e 'Hello\\nBuildroot' > original.txt")

        # Convert the original UNIX file to DOS
        self.assertRunOk("unix2dos -n original.txt dos.txt")

        # DOS file is expected to be different than the UNIX file
        _, exit_code = self.emulator.run("cmp original.txt dos.txt")
        self.assertNotEqual(exit_code, 0)

        # The "cat -A" command should print '^M$' for CR-LF
        self.assertRunOk("cat -A dos.txt | grep -Fq '^M$'")

        # Convert back DOS file to UNIX
        self.assertRunOk("dos2unix -n dos.txt unix.txt")

        # "unix.txt" should be identical to "original.txt"
        self.assertRunOk("cmp original.txt unix.txt")
