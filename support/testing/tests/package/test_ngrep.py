import os
import time

import infra.basetest


class TestNgrep(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_NETCAT=y
        BR2_PACKAGE_NGREP=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        port = 12345
        msg = 'Hello Buildroot'

        # Check the program can execute.
        self.assertRunOk("ngrep -V")

        # Start a netcat server in background accepting connections
        cmd = f"nc -l -p {port} >/dev/null </dev/null &"
        self.assertRunOk(cmd)

        time.sleep(1)

        # Start a netcat client in background, sending one message
        # every seconds
        cmd = "( while true ; do "
        cmd += f"echo '{msg}'; "
        cmd += "sleep 1 ; "
        cmd += "done) | "
        cmd += f"nc 127.0.0.1 {port} &"
        self.assertRunOk(cmd)

        time.sleep(1)

        # Capture 3 packets with the message.
        cmd = f"ngrep -n 3 '{msg}'"
        self.assertRunOk(cmd)
