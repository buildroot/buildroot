import os
import time

import infra.basetest


class TestSoCat(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_NETCAT=y
        BR2_PACKAGE_SOCAT=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Some values, for the test.
        msg = "Hello Buildroot!"
        out_file = "output.txt"
        port1 = 11111
        port2 = 22222

        # Check the program can execute.
        self.assertRunOk("socat -V")

        # We start the receiver netcat on tcp/port2.
        cmd = f"nc -n -l -p {port2} > {out_file} 2> /dev/null &"
        self.assertRunOk(cmd)

        time.sleep(2 * self.timeout_multiplier)

        # We start socat in background to listen on tcp/port1 and
        # forward to tcp/port2.
        cmd = f"socat TCP4-LISTEN:{port1} TCP4:127.0.0.1:{port2} &"
        self.assertRunOk(cmd)

        time.sleep(2 * self.timeout_multiplier)

        # We write a message on tcp/port1. Socat is expected to
        # forward the message to the receiver on tcp/port2, and write
        # our message in a file.
        cmd = f"echo '{msg}' | nc -n -c 127.0.0.1 {port1}"
        self.assertRunOk(cmd)

        # We check the output file contains our message.
        cmd = f"cat {out_file}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)
