import infra.basetest
from tests.init.base import InitSystemBase as InitSystemBase


class InitSystemSystemdBase(InitSystemBase):
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_INIT_SYSTEMD=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PER_PACKAGE_DIRECTORIES=y
        """

    def check_systemd(self, fs):
        self.start_emulator(fs)
        self.check_init("/lib/systemd/systemd")

        # Test all units are OK
        output, _ = self.emulator.run("systemctl --no-pager --failed --no-legend")
        self.assertEqual(len(output), 0)

        # Test we can reach the DBus daemon
        self.assertRunOk("busctl --no-pager")

        # Test we can read at least one line from the journal
        output, _ = self.emulator.run("journalctl --no-pager --lines 1 --quiet")
        self.assertEqual(len(output), 1)

        # Check the network is up
        self.check_network("eth0")


class TestInitSystemSystemdRoNetworkd(InitSystemSystemdBase):
    config = InitSystemSystemdBase.config + \
        """
        BR2_SYSTEM_DHCP="eth0"
        # BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW is not set
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_SQUASHFS=y
        """.format(infra.filepath("tests/init/systemd-factory"))

    def test_run(self):
        self.check_systemd("squashfs")

        # This one must be executed on the target, to check that
        # the factory feature works as expected
        out, exit_code = self.emulator.run("cat /var/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "foobar")


class TestInitSystemSystemdRwNetworkd(InitSystemSystemdBase):
    config = InitSystemSystemdBase.config + \
        """
        BR2_SYSTEM_DHCP="eth0"
        BR2_TARGET_ROOTFS_EXT2=y
        """

    def test_run(self):
        self.check_systemd("ext2")


class TestInitSystemSystemdRoIfupdown(InitSystemSystemdBase):
    config = InitSystemSystemdBase.config + \
        """
        BR2_SYSTEM_DHCP="eth0"
        # BR2_PACKAGE_SYSTEMD_NETWORKD is not set
        # BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW is not set
        BR2_TARGET_ROOTFS_SQUASHFS=y
        """

    def test_run(self):
        self.check_systemd("squashfs")


class TestInitSystemSystemdRoIfupdownDbusbroker(TestInitSystemSystemdRoIfupdown):
    config = TestInitSystemSystemdRoIfupdown.config + \
        """
        BR2_PACKAGE_DBUS_BROKER=y
        """

    def test_run(self):
        # Parent class' test_run() method does exactly that, no more:
        self.check_systemd("squashfs")

        # Check that the dbus-broker daemon is running as non-root
        cmd = "find /proc/$(pidof dbus-broker) -maxdepth 1 -name exe -user dbus"
        out, _ = self.emulator.run(cmd)
        self.assertEqual(len(out), 1)


class TestInitSystemSystemdRoIfupdownDbusbrokerDbus(TestInitSystemSystemdRoIfupdownDbusbroker):
    config = TestInitSystemSystemdRoIfupdownDbusbroker.config + \
        """
        BR2_PACKAGE_DBUS=y
        """


class TestInitSystemSystemdRwIfupdown(InitSystemSystemdBase):
    config = InitSystemSystemdBase.config + \
        """
        BR2_SYSTEM_DHCP="eth0"
        # BR2_PACKAGE_SYSTEMD_NETWORKD is not set
        BR2_TARGET_ROOTFS_EXT2=y
        """

    def test_run(self):
        self.check_systemd("ext2")


class TestInitSystemSystemdRwIfupdownDbusbroker(TestInitSystemSystemdRwIfupdown):
    config = TestInitSystemSystemdRwIfupdown.config + \
        """
        BR2_PACKAGE_DBUS_BROKER=y
        """

    def test_run(self):
        # Parent class' test_run() method does exactly that, no more:
        self.check_systemd("ext2")

        # Check that the dbus-broker daemon is running as non-root
        cmd = "find /proc/$(pidof dbus-broker) -maxdepth 1 -name exe -user dbus"
        out, _ = self.emulator.run(cmd)
        self.assertEqual(len(out), 1)


class TestInitSystemSystemdRwIfupdownDbusbrokerDbus(TestInitSystemSystemdRwIfupdownDbusbroker):
    config = TestInitSystemSystemdRwIfupdownDbusbroker.config + \
        """
        BR2_PACKAGE_DBUS=y
        """


class TestInitSystemSystemdRoFull(InitSystemSystemdBase):
    config = InitSystemSystemdBase.config + \
        """
        BR2_SYSTEM_DHCP="eth0"
        # BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW is not set
        BR2_PACKAGE_SYSTEMD_JOURNAL_REMOTE=y
        BR2_PACKAGE_SYSTEMD_BACKLIGHT=y
        BR2_PACKAGE_SYSTEMD_BINFMT=y
        BR2_PACKAGE_SYSTEMD_COREDUMP=y
        BR2_PACKAGE_SYSTEMD_FIRSTBOOT=y
        BR2_PACKAGE_SYSTEMD_HIBERNATE=y
        BR2_PACKAGE_SYSTEMD_IMPORTD=y
        BR2_PACKAGE_SYSTEMD_LOCALED=y
        BR2_PACKAGE_SYSTEMD_LOGIND=y
        BR2_PACKAGE_SYSTEMD_MACHINED=y
        BR2_PACKAGE_SYSTEMD_POLKIT=y
        BR2_PACKAGE_SYSTEMD_QUOTACHECK=y
        BR2_PACKAGE_SYSTEMD_RANDOMSEED=y
        BR2_PACKAGE_SYSTEMD_RFKILL=y
        BR2_PACKAGE_SYSTEMD_SMACK_SUPPORT=y
        BR2_PACKAGE_SYSTEMD_SYSUSERS=y
        BR2_PACKAGE_SYSTEMD_VCONSOLE=y
        BR2_TARGET_ROOTFS_SQUASHFS=y
        """

    def test_run(self):
        self.check_systemd("squashfs")


class TestInitSystemSystemdRwFull(InitSystemSystemdBase):
    config = InitSystemSystemdBase.config + \
        """
        BR2_SYSTEM_DHCP="eth0"
        BR2_PACKAGE_SYSTEMD_JOURNAL_REMOTE=y
        BR2_PACKAGE_SYSTEMD_BACKLIGHT=y
        BR2_PACKAGE_SYSTEMD_BINFMT=y
        BR2_PACKAGE_SYSTEMD_COREDUMP=y
        BR2_PACKAGE_SYSTEMD_FIRSTBOOT=y
        BR2_PACKAGE_SYSTEMD_HIBERNATE=y
        BR2_PACKAGE_SYSTEMD_IMPORTD=y
        BR2_PACKAGE_SYSTEMD_LOCALED=y
        BR2_PACKAGE_SYSTEMD_LOGIND=y
        BR2_PACKAGE_SYSTEMD_MACHINED=y
        BR2_PACKAGE_SYSTEMD_POLKIT=y
        BR2_PACKAGE_SYSTEMD_QUOTACHECK=y
        BR2_PACKAGE_SYSTEMD_RANDOMSEED=y
        BR2_PACKAGE_SYSTEMD_RFKILL=y
        BR2_PACKAGE_SYSTEMD_SMACK_SUPPORT=y
        BR2_PACKAGE_SYSTEMD_SYSUSERS=y
        BR2_PACKAGE_SYSTEMD_VCONSOLE=y
        BR2_TARGET_ROOTFS_EXT2=y
        """

    def test_run(self):
        self.check_systemd("ext2")
