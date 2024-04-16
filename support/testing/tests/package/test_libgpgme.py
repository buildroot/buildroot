import os

import infra.basetest


class TestLibGpgme(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LIBGPGME=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the binary program can execute.
        self.assertRunOk("gpgme-tool --version")

        # Some common data for all the tests.
        plain_data = "Hello Buildroot!"
        gpg_userid = "br-test@buildroot"
        plain_file = "reference-plain.txt"
        enc_file = "encrypted.dat"
        dec_file = "decrypted.txt"

        # We did not create a gpg key yet. We should not be able to
        # list our key.
        gpgme_listkey = f"echo LISTKEYS | gpgme-tool | grep '{gpg_userid}'"
        _, exit_code = self.emulator.run(gpgme_listkey)
        self.assertNotEqual(exit_code, 0)

        # We now create our gpg key.
        cmd = "gpg --batch --passphrase ''"
        cmd += f" --quick-generate-key {gpg_userid} default default"
        self.assertRunOk(cmd, timeout=30)

        # We should now see our key in the list.
        self.assertRunOk(gpgme_listkey)

        # We generate a plain text data file.
        cmd = f"echo '{plain_data}' > {plain_file}"
        self.assertRunOk(cmd)

        # We encrypt the plain text file using gpgme-tool commands.
        gpgme_enc_cmds = [
            "RESET",
            f"INPUT FILE={plain_file}",
            f"OUTPUT FILE={enc_file}",
            f"RECIPIENT {gpg_userid}",
            "ENCRYPT",
            "BYE"
        ]
        cmd = "gpgme-tool <<EOF\n"
        cmd += "\n".join(gpgme_enc_cmds)
        cmd += "\nEOF"
        self.assertRunOk(cmd)

        # The output encrypted file is supposed to exist and to have a
        # size greater than zero.
        self.assertRunOk(f"test -s {enc_file}")

        # The output encrypted file is also expected to be different
        # from the input plain text file.
        _, exit_code = self.emulator.run(f"cmp {plain_file} {enc_file}")
        self.assertNotEqual(exit_code, 0)

        # We now decrypt the encrypted file using gpgme-tool commands.
        gpgme_dec_cmds = [
            "RESET",
            f"INPUT FILE={enc_file}",
            f"OUTPUT FILE={dec_file}",
            "DECRYPT",
            "BYE"
        ]
        cmd = "gpgme-tool <<EOF\n"
        cmd += "\n".join(gpgme_dec_cmds)
        cmd += "\nEOF"
        self.assertRunOk(cmd)

        # The decrypted file is supposed to be the same as the initial
        # plain text file.
        cmd = f"cmp {plain_file} {dec_file}"
        self.assertRunOk(cmd)
