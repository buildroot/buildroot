import os

import infra.basetest


class TestGnupg2(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_GNUPG2=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Some common data for all the tests
        plain_data = "Some plain text data"
        plain_file = "file.txt"
        gpg_file = plain_file + ".gpg"
        asc_file = plain_file + ".asc"
        sig_file = plain_file + ".sig"
        good_passphrase = "Good Passphrase"
        gpg_userid = "br-test@buildroot"

        # Test the program can execute
        self.assertRunOk("gpg --version")

        # Generate plain text data
        cmd = "echo '{}' > {}".format(plain_data, plain_file)
        self.assertRunOk(cmd)

        # Test symmetric encrypt
        cmd = "gpg --batch --symmetric"
        cmd += " --passphrase '{}' {}".format(good_passphrase, plain_file)
        self.assertRunOk(cmd)

        # Test symmetric decrypt
        cmd = "gpg --batch --decrypt"
        cmd += " --passphrase '{}' {}".format(good_passphrase, gpg_file)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn(plain_data, output)

        # Test a failed decrypt with a bad password
        cmd = "gpg --batch --decrypt"
        cmd += " --passphrase 'A-Bad-Password' {}".format(gpg_file)
        _, exit_code = self.emulator.run(cmd)
        self.assertNotEqual(exit_code, 0)

        # Test the generation of an asymmetric key
        cmd = "gpg --batch --passphrase ''"
        cmd += " --quick-generate-key {} default default".format(gpg_userid)
        self.assertRunOk(cmd)

        # Test asymmetric encrypt+sign
        cmd = "gpg --batch --yes --encrypt --sign"
        cmd += " --recipient {} {}".format(gpg_userid, plain_file)
        self.assertRunOk(cmd)

        # Test asymmetric decrypt+verify
        cmd = "gpg --decrypt {}".format(gpg_file)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn(plain_data, output)
        self.assertRegex("\n".join(output), r'gpg: Good signature')

        # Test asymmetric armored encrypt+sign
        cmd = "gpg --batch --yes --armor --encrypt --sign"
        cmd += " --recipient {} {}".format(gpg_userid, plain_file)
        self.assertRunOk(cmd)

        # Test asymmetric armored decrypt+verify
        cmd = "gpg --armor --decrypt {}".format(asc_file)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn(plain_data, output)
        self.assertRegex("\n".join(output), r'gpg: Good signature')

        # Test detached signature
        cmd = "gpg --batch --yes --detach-sign {}".format(plain_file)
        self.assertRunOk(cmd)

        # Test detached signature verification
        cmd = "gpg --verify {}".format(sig_file)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertRegex("\n".join(output), r'gpg: Good signature')

        # Test detached armored signature
        cmd = "gpg --batch --yes --armor --detach-sign {}".format(plain_file)
        self.assertRunOk(cmd)

        # Test detached armored signature verification
        cmd = "gpg --armor --verify {}".format(asc_file)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertRegex("\n".join(output), r'gpg: Good signature')

        # Test the signature verification of a corrupted file actually fails
        cmd = "echo 'CORRUPTED' >> {}".format(plain_file)
        self.assertRunOk(cmd)

        cmd = "gpg --verify {}".format(sig_file)
        _, exit_code = self.emulator.run(cmd)
        self.assertNotEqual(exit_code, 0)

        cmd = "gpg --armor --verify {}".format(asc_file)
        _, exit_code = self.emulator.run(cmd)
        self.assertNotEqual(exit_code, 0)
