import os

import infra.basetest


class TestLtpTestsuite(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LTP_TESTSUITE=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="600M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           kernel_cmdline=["rootwait", "root=/dev/sda"],
                           options=["-drive", f"file={drive},if=scsi,format=raw"])
        self.emulator.login()

        # We run a reduced number of tests (read syscall tests) for a
        # fast execution. See "runltp --help" for option details.
        cmd = "/usr/lib/ltp-testsuite/runltp"
        cmd += " -p -q"
        cmd += " -s ^read0[0-9]*"
        cmd += " -l /tmp/ltp.log"
        cmd += " -o /tmp/ltp.output"
        cmd += " -C /tmp/ltp.failed"
        cmd += " -T /tmp/ltp.tconf"
        self.assertRunOk(cmd)

        # We print the LTP run log and check there was zero failure in
        # our test selection.
        out, ret = self.emulator.run("cat /tmp/ltp.log")
        self.assertEqual(ret, 0)
        self.assertIn("Total Failures: 0", out)
