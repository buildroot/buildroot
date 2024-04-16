import infra.basetest
import re
from tests.init.base import InitSystemBase as InitSystemBase


# In the following tests, the read-only cases use the default settings,
# which historically used both a factory to populate a tmpfs on /var,
# and pre-populated /var at buildtime. Since these are the default
# settings, and they proved to generate a system that ultimately boots,
# we still want to keep testing that. See later, below, for the
# specialised test cases.

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
        if "BR2_LINUX_KERNEL=y" in self.config:
            self.start_emulator(fs, "zImage", "vexpress-v2p-ca9")
        else:
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
        BR2_TARGET_ROOTFS_SQUASHFS=y
        """

    def test_run(self):
        self.check_systemd("squashfs")


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


# The following tests are all about read-only rootfs, and exercise either
# using an un-populated factory for /var, or an overlaysfs ontop of a
# pre-populated /var. They all specialise the TestInitSystemSystemdRo*
# test cases above.


# Helper class for factory-based tests
class InitSystemSystemdBaseFactory():
    config = \
        """
        # BR2_INIT_SYSTEMD_POPULATE_TMPFILES is not set
        BR2_ROOTFS_OVERLAY="{}"
        """.format(infra.filepath("tests/init/systemd-factory"))

    def test_run(self):
        super().test_run()

        # This one must be executed on the target, to check that
        # the factory feature works as expected
        out, exit_code = self.emulator.run("cat /var/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "foobar")

        # /var/foo/bar is from the /var factory
        _, exit_code = self.emulator.run("test -e /usr/share/factory/var/foo/bar")
        self.assertEqual(exit_code, 0)

        # We can write in /var/foo/bar
        _, exit_code = self.emulator.run("echo barfoo >/var/foo/bar")
        self.assertEqual(exit_code, 0)
        # ... and it contains the new content
        out, exit_code = self.emulator.run("cat /var/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "barfoo")
        # ... but the factory is umodified
        out, exit_code = self.emulator.run("cat /usr/share/factory/var/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "foobar")


class TestInitSystemSystemdRoNetworkdFactory(
    InitSystemSystemdBaseFactory,
    TestInitSystemSystemdRoNetworkd,
):
    config = InitSystemSystemdBaseFactory.config + \
        TestInitSystemSystemdRoNetworkd.config


class TestInitSystemSystemdRoIfupdownFactory(
    InitSystemSystemdBaseFactory,
    TestInitSystemSystemdRoIfupdown,
):
    config = InitSystemSystemdBaseFactory.config + \
        TestInitSystemSystemdRoIfupdown.config


class TestInitSystemSystemdRoIfupdownDbusbrokerFactory(
    InitSystemSystemdBaseFactory,
    TestInitSystemSystemdRoIfupdownDbusbroker,
):
    config = InitSystemSystemdBaseFactory.config + \
        TestInitSystemSystemdRoIfupdownDbusbroker.config


class TestInitSystemSystemdRoIfupdownDbusbrokerDbusFactory(
    InitSystemSystemdBaseFactory,
    TestInitSystemSystemdRoIfupdownDbusbrokerDbus,
):
    config = InitSystemSystemdBaseFactory.config + \
        TestInitSystemSystemdRoIfupdownDbusbrokerDbus.config


class TestInitSystemSystemdRoFullFactory(
    InitSystemSystemdBaseFactory,
    TestInitSystemSystemdRoFull,
):
    config = InitSystemSystemdBaseFactory.config + \
        TestInitSystemSystemdRoFull.config


# Helper class for overlayfs-based tests
class InitSystemSystemdBaseOverlayfs():
    config = \
        """
        # BR2_INIT_SYSTEMD_VAR_FACTORY is not set
        BR2_INIT_SYSTEMD_VAR_OVERLAYFS=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.10.202"
        BR2_LINUX_KERNEL_DEFCONFIG="vexpress"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{}"
        BR2_LINUX_KERNEL_DTS_SUPPORT=y
        BR2_LINUX_KERNEL_INTREE_DTS_NAME="vexpress-v2p-ca9"
        """.format(infra.filepath("tests/init/systemd-factory"),
                   infra.filepath("conf/overlayfs-kernel-fragment.config"))

    def test_run(self):
        super().test_run()

        # This one must be executed on the target, to check that
        # the tmpfiles pre-populate works as expected
        out, exit_code = self.emulator.run("cat /var/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "foobar")

        # /var/foo/bar is from the pre-populated /var, so it should
        # not be present in the upper of the overlay
        _, exit_code = self.emulator.run("test -e /run/buildroot/mounts/var/upper/foo/bar")
        self.assertNotEqual(exit_code, 0)

        # We can write in /var/foo/bar
        _, exit_code = self.emulator.run("echo barfoo >/var/foo/bar")
        self.assertEqual(exit_code, 0)
        # ... and it contains the new content
        out, exit_code = self.emulator.run("cat /var/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "barfoo")
        # ... and it to appears in the upper
        _, exit_code = self.emulator.run("test -e /run/buildroot/mounts/var/upper/foo/bar")
        self.assertEqual(exit_code, 0)
        # ... with the new content
        out, exit_code = self.emulator.run("cat /run/buildroot/mounts/var/upper/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "barfoo")
        # ... while the lower still has the oldcontent
        out, exit_code = self.emulator.run("cat /run/buildroot/mounts/var/lower/foo/bar")
        self.assertEqual(exit_code, 0)
        self.assertEqual(out[0], "foobar")


class TestInitSystemSystemdRoNetworkdOverlayfs(
    InitSystemSystemdBaseOverlayfs,
    TestInitSystemSystemdRoNetworkd,
):
    config = InitSystemSystemdBaseOverlayfs.config + \
        TestInitSystemSystemdRoNetworkd.config


class TestInitSystemSystemdRoIfupdownOverlayfs(
    InitSystemSystemdBaseOverlayfs,
    TestInitSystemSystemdRoIfupdown,
):
    config = InitSystemSystemdBaseOverlayfs.config + \
        TestInitSystemSystemdRoIfupdown.config


class TestInitSystemSystemdRoIfupdownDbusbrokerOverlayfs(
    InitSystemSystemdBaseOverlayfs,
    TestInitSystemSystemdRoIfupdownDbusbroker,
):
    config = InitSystemSystemdBaseOverlayfs.config + \
        TestInitSystemSystemdRoIfupdownDbusbroker.config


class TestInitSystemSystemdRoIfupdownDbusbrokerDbusOverlayfs(
    InitSystemSystemdBaseOverlayfs,
    TestInitSystemSystemdRoIfupdownDbusbrokerDbus,
):
    config = InitSystemSystemdBaseOverlayfs.config + \
        TestInitSystemSystemdRoIfupdownDbusbrokerDbus.config


class TestInitSystemSystemdRoFullOverlayfs(
    InitSystemSystemdBaseOverlayfs,
    TestInitSystemSystemdRoFull,
):
    config = InitSystemSystemdBaseOverlayfs.config + \
        TestInitSystemSystemdRoFull.config


class InitSystemSystemdBaseOverlayfsVarBacking(InitSystemBase):
    @classmethod
    def gen_config(cls, overlaydir: str) -> str:
        return re.sub(
            r'^\s*BR2_ROOTFS_OVERLAY="(.*)"$',
            'BR2_ROOTFS_OVERLAY="\\1 {}"'.format(infra.filepath(overlaydir)),
            TestInitSystemSystemdRoFullOverlayfs.config,
            flags=re.MULTILINE,
        )

    def check_var_mounted(self):
        self.assertRunOk("grep '^other-var-backing-store /run/buildroot/mounts/var tmpfs' /proc/mounts")


class TestInitSystemSystemdRoFullOverlayfsVarBackingMountUnit(
    TestInitSystemSystemdRoFullOverlayfs,
    InitSystemSystemdBaseOverlayfsVarBacking,
):
    config = InitSystemSystemdBaseOverlayfsVarBacking.gen_config(
        'tests/init/systemd-overlay-mount-unit',
    )

    def test_run(self):
        super().test_run()
        self.check_var_mounted()


class TestInitSystemSystemdRoFullOverlayfsVarBackingFstab(
    TestInitSystemSystemdRoFullOverlayfs,
    InitSystemSystemdBaseOverlayfsVarBacking,
):
    config = InitSystemSystemdBaseOverlayfsVarBacking.gen_config(
        'tests/init/systemd-overlay-fstab',
    )

    def test_run(self):
        super().test_run()
        self.check_var_mounted()
