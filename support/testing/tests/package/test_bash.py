import os

import infra.basetest


class TestBash(infra.basetest.BRTest):
    config = \
        """
        BR2_arm=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_ENABLE_LOCALE_WHITELIST=""
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_BASH=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check that we are indeed not (yet) running bash
        out, _ = self.emulator.run('echo "${BASH}"')
        self.assertEqual(out[0], "", "Already running bash instead of busybox' sh")

        self.assertRunOk("bash -il")
        # Twist! The above command is still running, it's just that
        # bash did display the prompt we expect. Check we are indeed
        # actually bash
        out, _ = self.emulator.run('echo "${BASH}"')
        self.assertEqual(out[0], "/bin/bash", "Not running bash")
        # Exit bash, back to busybox' shell
        self.emulator.run("exit 0")

        # Check that we are indeed no longer running bash
        out, _ = self.emulator.run('echo "${BASH}"')
        self.assertEqual(out[0], "", "Still running bash instead of busybox' sh")

        # Try to run with a non-available locale
        self.assertRunOk("LC_ALL=en_US bash -il")
        out, _ = self.emulator.run('echo "${BASH}"')
        self.assertEqual(out[0], "/bin/bash", "Not running bash")
        self.emulator.run("exit 0")
