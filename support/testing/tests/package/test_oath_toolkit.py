import os

import infra.basetest


class TestOathToolKit(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_OATH_TOOLKIT=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("oathtool --version")

        # Test commands and expected results are coming from examples
        # producing stable/reproducible outputs given in the oathtool
        # manual page. See:
        # https://www.nongnu.org/oath-toolkit/oathtool.1.html

        tests = [
            ("echo 00 | oathtool -", "328482"),
            ("oathtool -c 5 3132333435363738393031323334353637383930", "254676"),
            ("oathtool -w 10 3132333435363738393031323334353637383930 969429", "3"),
            ("oathtool --totp --now \"2008-04-23 17:42:17 UTC\" 00", "974945")
        ]

        for cmd, expected_out in tests:
            out, ret = self.emulator.run(cmd)
            self.assertEqual(ret, 0, f"Failed to run '{cmd}'")
            self.assertEqual(expected_out, out[0])
