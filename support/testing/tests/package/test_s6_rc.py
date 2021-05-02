import os

import infra.basetest


class TestS6Rc(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_S6_RC=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()

        _, exit_code = self.emulator.run("s6-svscan -h")
        self.assertEqual(exit_code, 100)

        # Set up two service directories with a dependency
        self.emulator.run("mkdir -p source/testsv1")
        self.emulator.run("mkdir -p source/testsv2")
        self.emulator.run("echo oneshot > source/testsv1/type")
        self.emulator.run("echo oneshot > source/testsv2/type")
        self.emulator.run("echo 'echo foo' > source/testsv1/up")
        self.emulator.run("echo 'echo bar' > source/testsv2/up")
        self.emulator.run("echo testsv1 > source/testsv2/dependencies")
        self.emulator.run("chmod +x source/testsv1/up")
        self.emulator.run("chmod +x source/testsv2/up")

        # Compile the service database
        _, exit_code = self.emulator.run("s6-rc-compile compiled source")
        self.assertEqual(exit_code, 0)

        # Inspect dependencies
        cmd = "s6-rc-db -c compiled -d dependencies testsv1"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "testsv2")
        cmd = "s6-rc-db -c compiled dependencies testsv2"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "testsv1")
