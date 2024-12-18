import os

import infra.basetest


class TestPatch(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_patch/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_PATCH=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute. This also checks that we are
        # not using the patch applet from BusyBox (as it does not
        # recognize the --version option).
        self.assertRunOk("patch --version")

        # We check the test file contains our expected string before
        # the patch.
        sed_cmd = "sed -n '2p' file.txt"
        out, ret = self.emulator.run(sed_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "Hello World!")

        # We apply our test patch...
        self.assertRunOk("patch -p1 < file.diff")

        # We check the test file contains our expected string after
        # applying the patch.
        out, ret = self.emulator.run(sed_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "Hello Buildroot!")
