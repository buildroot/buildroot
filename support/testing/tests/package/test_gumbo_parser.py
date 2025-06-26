import os

import infra.basetest


class TestGumboParser(infra.basetest.BRTest):
    br2_external = [infra.filepath("tests/package/br2-external/gumbo-parser")]
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_GUMBO_PARSER=y
        BR2_PACKAGE_GUMBO_PARSER_TEST=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Run the test program and check output
        out, ret = self.emulator.run("/usr/bin/gumbo_test")
        self.assertEqual(ret, 0)
        self.assertIn("HTML parsing successful", "\n".join(out))
        self.assertIn("Found title: Test HTML", "\n".join(out))
