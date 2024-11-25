import os
import time

import infra.basetest


class TestGpsd(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_gpsd/rootfs-overlay")
    # This test is using the gpsfake Python script.
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_GPSD=y
        BR2_PACKAGE_GPSD_PYTHON=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can execute.
        self.assertRunOk("gpsd --version")

        # Since gpsd needs a real GPS device, we stop the service.
        self.assertRunOk("/etc/init.d/S50gpsd stop")

        # We start the "gpsfake" GPS emulator instead.
        cmd = "gpsfake"
        cmd += " --slow --cycle 0.1 --quiet"
        cmd += " /root/udp-nmea.log &> /dev/null &"
        self.assertRunOk(cmd)

        # Wait a bit, to let the gpsfake and gpsd to settle...
        time.sleep(3 * self.timeout_multiplier)

        # List the GPS devices. We should see our local UDP test GPS.
        out, ret = self.emulator.run("gpsctl")
        self.assertEqual(ret, 0)
        self.assertTrue(out[0].startswith("udp://127.0.0.1"))
        self.assertIn("NMEA0183", out[0])

        # Collect some of our fake GPS data, and check we got the
        # coordinates from our test data file.
        # Our expected coordinates are:
        # https://www.openstreetmap.org/#map=19/43.60439/1.44336
        out, ret = self.emulator.run("gpscsv --header 0 --count 3")
        self.assertEqual(ret, 0)
        _, gps_lat, gps_long, _ = out[0].split(",")
        self.assertAlmostEqual(float(gps_lat), 43.60439)
        self.assertAlmostEqual(float(gps_long), 1.44336)
