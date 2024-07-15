import os

import infra.basetest


class TestS6Networking(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_S6_NETWORKING=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()

        # Test the TAICLOCK server and client
        _, exit_code = self.emulator.run("s6-taiclockd &")
        self.emulator.run("sleep 2")
        cmd = "s6-taiclock 127.0.0.1 | s6-clockview"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0][0:6], "before")
        self.assertEqual(output[1][0:5], "after")

        # Test the TCP server and client
        _, exit_code = self.emulator.run("s6-tcpserver 127.0.0.1 1024 cat &")
        self.emulator.run("sleep 2")
        cmd = "echo foobar | s6-tcpclient 127.0.0.1 1024 s6-ioconnect -67"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "foobar")
