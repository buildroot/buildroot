import os
import time

import infra.basetest


class TestFping(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_FPING=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("fping --version")

        # Fping v5.1 need to wait few seconds after a kernel booted
        # before starting. This sleep time can be removed when the
        # issue will be closed and the package updated. See:
        # https://github.com/schweikert/fping/issues/288
        time.sleep(5 * self.timeout_multiplier)

        # Run 3 pings on localhost.
        self.assertRunOk("fping -e -c 3 localhost")

        # Run pings on a local subnet and print statistics.
        self.assertRunOk("fping -s -g 127.0.0.0/28")

        # Test an IPv6 ping.
        self.assertRunOk("fping -6 ::1")

        # Create a prohibited route to make fping fail.
        self.assertRunOk("ip route add to prohibit 192.168.12.0/24")

        # We expect fping to fail when pinging the prohibited network.
        _, ret = self.emulator.run("fping 192.168.12.34")
        self.assertNotEqual(ret, 0)
