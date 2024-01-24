import os

import infra.basetest


class TestFile(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_FILE=y
        BR2_ROOTFS_OVERLAY="{infra.filepath("tests/package/test_file/rootfs-overlay")}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("file --version")

        tests = [
            ("", "plain-text.txt", "ASCII text"),
            ("-i", "plain-text.txt", "text/plain"),
            ("", "plain-text.txt.gz", "gzip compressed data"),
            ("-i", "plain-text.txt.gz", "application/gzip"),
            ("-z", "plain-text.txt.gz", "ASCII text"),
            ("", "random-data.bin", "data"),
            ("-i", "random-data.bin", "application/octet-stream"),
            ("", "code.c", "C source"),
            ("-i", "code.c", "text/x-c"),
            ("", "script.sh", "POSIX shell script"),
            ("-i", "script.sh", "text/x-shellscript"),
            ("", "script.py", "Python script"),
            ("", "/usr/share/misc/magic.mgc", "magic binary file for file"),
            ("", "/usr/bin/file", "ELF"),
            ("", "/dev/zero", "character special"),
            ("", "/", "directory"),
            ("-h", "symlink-to-plain-text.txt", "symbolic link"),
            ("-L", "symlink-to-plain-text.txt", "ASCII text")
        ]
        for opt_str, path, pattern in tests:
            cmd = f"file {opt_str} '{path}'"
            out, ret = self.emulator.run(cmd)
            self.assertEqual(ret, 0, f"Failed to run '{cmd}'")
            self.assertIn(pattern, "\n".join(out))
