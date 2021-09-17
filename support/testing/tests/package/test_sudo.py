import os

import infra.basetest


class TestSudo(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_SUDO=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()

        # -D    don't set a password
        # -h    set home directory
        # -H    don't create home directory
        # -s    set shell
        self.assertRunOk("adduser -D -h /tmp -H -s /bin/sh sudotest")

        self.assertRunOk("echo 'sudotest ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers")

        output, exit_code = self.emulator.run("su - sudotest -c 'echo hello world'")
        self.assertEqual(output, ["hello world"])

        output, exit_code = self.emulator.run("su - sudotest -c 'sudo echo hello world'")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output, ["hello world"])
