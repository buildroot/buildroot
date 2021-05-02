import os
import textwrap

import infra.basetest


class TestS6(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_S6=y
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

        script = \
            """
            #!/bin/execlineb -P
            s6-ipcserver-socketbinder /tmp/socket
            s6-ipcserverd
            cat
            """
        script = textwrap.dedent(script)

        # Set up scanning and service directories
        self.emulator.run("mkdir -p source/testsv")
        self.emulator.run("cat > source/testsv/run <<EOF" + script + "EOF")
        self.emulator.run("chmod +x source/testsv/run")
        _, exit_code = self.emulator.run("s6-svok source/testsv")
        self.assertEqual(exit_code, 1)

        # Run a scan and start all services
        self.emulator.run("s6-svscan source &")
        self.emulator.run("sleep 2")
        _, exit_code = self.emulator.run("s6-svok source/testsv")
        self.assertEqual(exit_code, 0)

        # Test a running service
        cmd = "echo foobar | s6-ipcclient /tmp/socket s6-ioconnect -67"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "foobar")

        # Terminate all services
        _, exit_code = self.emulator.run("s6-svscanctl -t source")
        self.assertEqual(exit_code, 0)
        self.emulator.run("sleep 2")
        _, exit_code = self.emulator.run("s6-svok source/testsv")
        self.assertEqual(exit_code, 1)
