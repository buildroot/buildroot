import os

import infra.basetest


class TestAtftp(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ATFTP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_ROOTFS_CPIO=y
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])

        self.emulator.login()

        self.assertRunOk("mkdir -p /tftpboot")
        self.assertRunOk("echo 'Hello World' >/tftpboot/test_atftp.txt")

        # atftpd is launched by /etc/init.d/S80atftpd
        self.assertRunOk("atftp -g -r test_atftp.txt -l /tmp/test_atftp.txt localhost")
        output, exit_code = self.emulator.run("cat /tmp/test_atftp.txt")
        self.assertEqual("".join(output), "Hello World")
