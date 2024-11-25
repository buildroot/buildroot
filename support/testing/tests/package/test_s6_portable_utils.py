import os

import infra.basetest


class TestS6PortableUtils(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_S6_PORTABLE_UTILS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()

        output, exit_code = self.emulator.run("s6-basename /sbin/init")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0].strip(), "init")

        output, exit_code = self.emulator.run("s6-echo hello world | s6-cut -d' ' -f2")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0].strip(), "world")

        _, exit_code = self.emulator.run("s6-mkfifo testpipe")
        self.assertEqual(exit_code, 0)
        _, exit_code = self.emulator.run("test -p testpipe")
        self.assertEqual(exit_code, 0)
