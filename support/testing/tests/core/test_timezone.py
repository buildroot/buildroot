import os

import infra.basetest


def boot_armv5_cpio(emulator, builddir):
    img = os.path.join(builddir, "images", "rootfs.cpio")
    emulator.boot(arch="armv5", kernel="builtin",
                  options=["-initrd", img])
    emulator.login()

    # emulator.login() sets the emulated system date to the host
    # date. In general, this is desirable (for correct SSL certificate
    # behaviors, for example).
    #
    # This timezone runtime test checks that a Buildroot configuration
    # is reflected in the generated system at runtime, using the
    # standard "date" command. To make sure this test is stable in
    # time (i.e. output is independent to the date/time the test is
    # executed due to daylight saving time changes), we reset the
    # system date to a constant value.
    #
    # We cannot set the system date to a value less than the system
    # uptime. So we cannot set the time back to Unix Epoch with the
    # command "date -s @0" (this would result to a EINVAL Invalid
    # argument). Instead, we set the time at 1 hour after Epoch. This
    # is sufficient as the emulated system takes few seconds to start.
    emulator.run("date -s @3600")


class TestNoTimezone(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        # BR2_TARGET_TZ_INFO is not set
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        boot_armv5_cpio(self.emulator, self.builddir)
        tz, _ = self.emulator.run("TZ=UTC date +%Z")
        self.assertEqual(tz[0].strip(), "UTC")
        # This test is Glibc specific since there is no Time Zone Database installed
        # and other C libraries use their own rule for returning time zone name or
        # abbreviation when TZ is empty or set with a not installed time zone data file.
        tz, _ = self.emulator.run("TZ= date +%Z")
        self.assertEqual(tz[0].strip(), "Universal")


class TestAllTimezone(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_TZ_INFO=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        boot_armv5_cpio(self.emulator, self.builddir)
        tz, _ = self.emulator.run("date +%Z")
        self.assertEqual(tz[0].strip(), "UTC")
        tz, _ = self.emulator.run("TZ=UTC date +%Z")
        self.assertEqual(tz[0].strip(), "UTC")
        tz, _ = self.emulator.run("TZ=America/Los_Angeles date +%Z")
        self.assertEqual(tz[0].strip(), "PST")
        tz, _ = self.emulator.run("TZ=Europe/Paris date +%Z")
        self.assertEqual(tz[0].strip(), "CET")


class TestNonDefaultLimitedTimezone(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_TZ_INFO=y
        BR2_TARGET_TZ_ZONELIST="northamerica"
        BR2_TARGET_LOCALTIME="America/New_York"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        boot_armv5_cpio(self.emulator, self.builddir)
        tz, _ = self.emulator.run("date +%Z")
        self.assertEqual(tz[0].strip(), "EST")
        tz, _ = self.emulator.run("TZ=UTC date +%Z")
        self.assertEqual(tz[0].strip(), "UTC")
        tz, _ = self.emulator.run("TZ=America/Los_Angeles date +%Z")
        self.assertEqual(tz[0].strip(), "PST")
        tz, _ = self.emulator.run("TZ=Europe/Paris date +%Z")
        self.assertEqual(tz[0].strip(), "Europe")
