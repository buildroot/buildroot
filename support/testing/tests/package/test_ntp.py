import os
import re
import time

import infra.basetest


class TestNtp(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_ntp/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_NTP=y
        BR2_PACKAGE_NTP_NTPD=y
        BR2_PACKAGE_NTP_NTPQ=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def dict_from_ntpq_output(self, output):
        d = {}
        for line in output:
            if ':' not in line:
                continue
            fields = re.split(r":", line, maxsplit=2)
            name = fields[0].strip()
            value = fields[1].strip()
            d[name] = value
        return d

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check our binaries can execute.
        self.assertRunOk("ntpd --version")
        self.assertRunOk("ntpq --version")

        # The ntp daemon is expected to be started from init startup
        # scripts, for the Buildroot package recipe. We wait a bit
        # here to let the daemon settle. The next test step checks for
        # the local peer to be the system peer (by checking the
        # '*'). If querying the peers too soon after startup the peer
        # will not be marked as such.
        time.sleep(3 * self.timeout_multiplier)

        # We query the ntp daemon peers. From our test configuration
        # file, we should have exactly one.
        out, ret = self.emulator.run("ntpq --peers")
        self.assertEqual(ret, 0)
        # ntpq --peers produces two lines of headers. So we check we
        # have at least 3 lines of output.
        self.assertGreaterEqual(len(out), 3)
        # We check we see our undisciplined local clock and it's the
        # system peer.
        self.assertTrue(out[2].startswith("*LOCAL(0)"))

        # We query the refid variable. We expect to see our
        # undisciplined local clock.
        out, ret = self.emulator.run("ntpq -c 'readvar 0 refid'")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "refid=LOCAL(0)")

        # We query the ntp system info. We check the reference ID is
        # the same as in the test configuration file.
        out, ret = self.emulator.run("ntpq -c sysinfo")
        self.assertEqual(ret, 0)
        sysinfo = self.dict_from_ntpq_output(out)
        refid = "reference ID"
        self.assertIn(refid, sysinfo)
        self.assertEqual(sysinfo[refid], "127.127.1.0")

        # Finally, we query the ntp system statistics. We check we can
        # see some uptime. We waited a bit at the beginning of this
        # test, plus the few queries we previously did should have
        # accumulated some uptime.
        out, ret = self.emulator.run("ntpq -c sysstats")
        self.assertEqual(ret, 0)
        sysstats = self.dict_from_ntpq_output(out)
        up = "uptime"
        self.assertIn(up, sysstats)
        self.assertGreater(int(sysstats[up]), 0)
