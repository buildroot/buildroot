import os

import infra.basetest


class TestAgec(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + """
    BR2_PACKAGE_AGEC=y
    BR2_TARGET_ROOTFS_CPIO=y
    """

    # generate keypair in file and return pubkey
    def generate_keypair(self, filename):
        self.assertRunOk(f"agec-keygen > {filename}")

        output, exit_code = self.emulator.run(f"agec-keygen -y < {filename}")
        self.assertEqual(exit_code, 0)
        pubkey = output[0].strip()
        self.assertNotEqual(pubkey, "")
        return pubkey

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We define two keypairs
        key1 = "/tmp/key1.txt"
        key2 = "/tmp/key2.txt"

        # And files to work on
        orig_file = "/bin/busybox"
        decrypted_file = "/tmp/busybox"
        encrypted_file = decrypted_file + ".age"

        # should output a valid looking keypair to stdout
        output, exit_code = self.emulator.run("agec-keygen")
        self.assertEqual(exit_code, 0)
        self.assertIn("public key:", output[0])
        self.assertIn("AGE-SECRET-KEY-", output[1])

        # generate keypairs and extract pubkeys
        pubkey1 = self.generate_keypair(key1)
        _ = self.generate_keypair(key2)

        # encrypt file
        self.assertRunOk(f"agec -r {pubkey1} {orig_file} > {encrypted_file}")

        # should be encrypted
        self.assertRunNotOk(f"cmp {orig_file} {encrypted_file}")

        # should be decryptable with key1
        self.assertRunOk(f"agec -d -i {key1} {encrypted_file} > {decrypted_file}")

        # and equal to original
        self.assertRunOk(f"cmp {orig_file} {decrypted_file} ")

        # should NOT be decryptable with key2
        self.assertRunNotOk(f"agec -d -i {key2} {encrypted_file} > {decrypted_file}")
