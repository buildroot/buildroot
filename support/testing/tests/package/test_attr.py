import os


import infra.basetest


class TestAttr(infra.basetest.BRTest):
    # Note: this test uses extended attributes (xattr). We use a ext4
    # rootfs (which fully supports xattrs). Note that tmpfs has
    # partial support of xattrs, and cpio initrd has not.
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ATTR=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        disk_file = os.path.join(self.builddir, "images", "rootfs.ext4")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           kernel_cmdline=["rootwait", "root=/dev/sda"],
                           options=["-drive", f"file={disk_file},if=scsi,format=raw"])
        self.emulator.login()

        # Check the programs can execute.
        self.assertRunOk("getfattr --version")
        self.assertRunOk("setfattr --version")

        test_file = "/root/file.txt"
        attr_name = "buildroot"
        attr_value = "is-great"

        # Create a test file.
        self.assertRunOk(f"echo 'Hello Buildroot!' > {test_file}")

        # Set an extended attribute.
        cmd = f"setfattr -n user.{attr_name} -v {attr_value} {test_file}"
        self.assertRunOk(cmd)

        # Read back the attribute value. We add an extra "echo" to add
        # a new line. getfattr --only-values prints raw attribute
        # values and lack of a new line.
        cmd = "getfattr"
        cmd += f" -n user.{attr_name} --absolute-names --only-values"
        cmd += f" {test_file} && echo"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], attr_value)

        # We read back the attribute value again, but with the "attr"
        # command this time.
        cmd = f"attr -q -g {attr_name} {test_file} && echo"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], attr_value)

        # List extended attributes with "attr", and check we see our
        # test attribute.
        cmd = f"attr -l {test_file}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertIn(attr_name, "\n".join(out))

        # Remove the test attribute with setfattr.
        cmd = f"setfattr -x user.{attr_name} {test_file}"
        self.assertRunOk(cmd)

        # We check the test attribute is no longer listed by the attr
        # command.
        cmd = f"attr -l {test_file}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertNotIn(attr_name, "\n".join(out))
