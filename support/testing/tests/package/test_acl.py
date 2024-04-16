import os

import infra.basetest


class TestAcl(infra.basetest.BRTest):
    # Note: this test requires a Kernel with a filesystem on /tmp
    # supporting ACLs. This is the case for the basetest reference
    # config. Kernel has CONFIG_TMPFS_POSIX_ACL=y, and /tmp is tmpfs
    # in the default Buildroot config.
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ACL=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the programs can execute.
        self.assertRunOk("getfacl --version")
        self.assertRunOk("setfacl --version")

        # Constants used in this test.
        test_user = "acltest"
        test_data = "Hello Buildroot!"
        test_file = "/tmp/file.txt"

        # Create a test user:
        # -D    don't set a password
        # -h    set home directory
        # -H    don't create home directory
        # -s    set shell to /bin/sh
        self.assertRunOk(f"adduser -D -h /tmp -H -s /bin/sh {test_user}")

        # Create a test file, and make sure the owner is "root" with
        # standard Unix permissions to read/write only for the owner.
        self.assertRunOk(f"echo '{test_data}' > {test_file}")
        self.assertRunOk(f"chown root:root {test_file}")
        self.assertRunOk(f"chmod 0600 {test_file}")

        # Check we have no ACL for the test user.
        getacl_cmd = f"getfacl -c -p {test_file}"
        out, ret = self.emulator.run(getacl_cmd)
        self.assertEqual(ret, 0)
        self.assertNotIn(f"user:{test_user}:", "\n".join(out))

        # Reading the file as the test user is expected to fail.
        test_read_cmd = f"su - {test_user} -c 'cat {test_file}'"
        _, ret = self.emulator.run(test_read_cmd)
        self.assertNotEqual(ret, 0)

        # We add a special read ACL for the test user.
        cmd = f"setfacl -m u:{test_user}:r {test_file}"
        self.assertRunOk(cmd)

        # Check we now have an ACL entry for the test user.
        out, ret = self.emulator.run(getacl_cmd)
        self.assertEqual(ret, 0)
        self.assertIn(f"user:{test_user}:", "\n".join(out))

        # Reading the file as the test user is now expected to
        # succeed.
        out, ret = self.emulator.run(test_read_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], test_data)

        # Attempting to write to the file as the test user is expected
        # to fail (since we put an ACL only for reading).
        cmd = f"su - {test_user} -c 'echo WriteTest > {test_file}'"
        _, ret = self.emulator.run(cmd)
        self.assertNotEqual(ret, 0)

        # Remove all ACLs. This could have been done with the command
        # "setfacl -b". Instead, we use the "chacl -B" command which
        # is doing the same. The reason is to slightly improve the
        # coverage of this test, by including an execution of "chacl".
        self.assertRunOk(f"chacl -B {test_file}")

        # Reading the file as the test user is expected to fail again.
        _, ret = self.emulator.run(test_read_cmd)
        self.assertNotEqual(ret, 0)
