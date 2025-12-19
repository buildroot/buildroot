import os

import infra.basetest


class TestRasdaemon(infra.basetest.BRTest):
    config = f"""
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_LINUX_KERNEL=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.59"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{infra.filepath("tests/package/test_rasdaemon/linux-debugfs.fragment")}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_RASDAEMON=y
        BR2_PACKAGE_RASDAEMON_AER=y
        BR2_PACKAGE_LIBTRACEEVENT=y
        BR2_PACKAGE_SQLITE=y
        BR2_PACKAGE_PCIUTILS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        kernel = os.path.join(self.builddir, "images", "bzImage")
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(
                arch="x86_64",
                kernel=kernel,
                kernel_cmdline=["console=ttyS0"],
                options=["-cpu", "Nehalem",  "-initrd", cpio_file],
        )
        self.emulator.login()

        self.assertRunOk("/usr/sbin/rasdaemon --version")
        self.assertRunOk("mount -t debugfs nodev /sys/kernel/debug")
        self.assertRunOk("/etc/init.d/S95rasdaemon start")
        self.assertRunOk("pidof /usr/sbin/rasdaemon")
        self.assertRunOk("/etc/init.d/S95rasdaemon restart")
        self.assertRunOk("pidof /usr/sbin/rasdaemon")
        self.assertRunOk("/etc/init.d/S95rasdaemon stop")
        _, ret = self.emulator.run("pidof /usr/sbin/rasdaemon")
        self.assertNotEqual(ret, 0)
