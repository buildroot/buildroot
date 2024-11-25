import os

import infra.basetest


class TestWhich(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_WHICH=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can run. This also checks we are using
        # the actual GNU which, since the BusyBox implementation does
        # not accept this option.
        self.assertRunOk("which --version")

        # We check the primary usage is working.
        out, ret = self.emulator.run("which sh")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "/bin/sh")

        alias_name = "buildoot_test_alias"

        # We check "which" returns an error when the program is not
        # found.
        _, ret = self.emulator.run(f"which {alias_name}")
        self.assertNotEqual(ret, 0)

        # We define a shell alias.
        alias_cmd = "/bin/true"
        alias_def = f"{alias_name}='{alias_cmd}'"
        self.assertRunOk(f"alias {alias_def}")

        # We check our alias definition actually works, just by
        # invoking it (since it's aliased to "true").
        self.assertRunOk(alias_name)

        # We check "which" is able to read aliases from the shell.
        cmd = f"alias | which -i {alias_name}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], alias_def)
        self.assertEqual(out[1].strip(), alias_cmd)
