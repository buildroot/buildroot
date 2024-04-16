import os
import time

import infra.basetest


class TestTcpdump(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_TCPDUMP=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        capture_file = "capture.pcap"
        decode_log = "decode.log"

        # Check the program can execute.
        self.assertRunOk("tcpdump --version")

        # Run ping in background.
        cmd = "ping localhost >/dev/null &"
        self.assertRunOk(cmd)

        time.sleep(1)

        # Capture 3 packets with the message.
        cmd = f"tcpdump -c 3 -w {capture_file} icmp"
        self.assertRunOk(cmd)

        # Decode the capture file.
        cmd = f"tcpdump -r {capture_file} > {decode_log}"
        self.assertRunOk(cmd)

        # Check we have ICMP echo requests/replies in the
        # decoded capture.
        cmd = f"grep -E 'ICMP echo (request|reply)' {decode_log}"
        self.assertRunOk(cmd)
