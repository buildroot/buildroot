import json
import os

import infra.basetest


class TestLtpTestsuite(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LTP_TESTSUITE=y
        BR2_PACKAGE_PYTHON3=y
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

        ltp_root = "/usr/lib/ltp-testsuite"
        report_file = "/tmp/ltp-report.json"

        # We run a reduced number of tests (read syscall tests) for a
        # fast execution. See "kirk --help" for option details.
        cmd = f"LTPROOT={ltp_root}"
        cmd += f" {ltp_root}/kirk"
        cmd += " --sut host"
        cmd += " --framework ltp"
        cmd += " --run-suite syscalls"
        cmd += " --run-pattern '^read0[0-9]*'"
        cmd += f" --json-report {report_file}"
        self.assertRunOk(cmd, timeout=30)

        # We print the LTP report and check there was at least one
        # passed test and zero failure in our selection.
        out, ret = self.emulator.run(f"cat {report_file} && echo")
        self.assertEqual(ret, 0)
        report = json.loads("".join(out))
        self.assertEqual(report['stats']['failed'], 0)
        self.assertGreater(report['stats']['passed'], 0)
