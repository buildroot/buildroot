"""Test firewalld for both systemd and sysvinit."""
import os
import time
import infra.basetest


class TestFirewalldSystemd(infra.basetest.BRTest):
    """Build the kernel as firewalld requires several the nftable options."""

    config = """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_INIT_SYSTEMD=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.61"
        BR2_LINUX_KERNEL_DEFCONFIG="vexpress"
        BR2_LINUX_KERNEL_DTS_SUPPORT=y
        BR2_LINUX_KERNEL_INTREE_DTS_NAME="vexpress-v2p-ca9"
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_FIREWALLD=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        kernel_file = os.path.join(self.builddir, "images", "zImage")
        dtb_file = os.path.join(self.builddir, "images", "vexpress-v2p-ca9.dtb")
        self.emulator.boot(arch="armv7",
                           kernel=kernel_file,
                           kernel_cmdline=["console=ttyAMA0,115200"],
                           options=[
                               "-initrd", cpio_file,
                               "-dtb", dtb_file,
                               "-M", "vexpress-a9"
                           ])
        # It takes quite some time for the system to boot with firewalld,
        self.emulator.login(timeout=120)

        # It may take some time for firewalld to finish startup.
        # Give it at least 15 seconds.
        is_active = False
        for i in range(15):
            output, _ = self.emulator.run("systemctl is-active firewalld")
            if output[0] == "active":
                is_active = True
                break
            time.sleep(1)
        if not is_active:
            self.fail("firewalld failed to activate!")

        cmd = "firewall-cmd --state"
        output, exit_code = self.emulator.run(cmd, timeout=10)
        self.assertIn("running", output[0])
        self.assertEqual(exit_code, 0)


class TestFirewalldSysVInit(infra.basetest.BRTest):
    """Build the kernel as firewalld requires several nftable options."""

    config = """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.61"
        BR2_LINUX_KERNEL_DEFCONFIG="vexpress"
        BR2_LINUX_KERNEL_DTS_SUPPORT=y
        BR2_LINUX_KERNEL_INTREE_DTS_NAME="vexpress-v2p-ca9"
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_FIREWALLD=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        kernel_file = os.path.join(self.builddir, "images", "zImage")
        dtb_file = os.path.join(self.builddir, "images", "vexpress-v2p-ca9.dtb")
        self.emulator.boot(arch="armv7",
                           kernel=kernel_file,
                           kernel_cmdline=["console=ttyAMA0,115200"],
                           options=[
                               "-initrd", cpio_file,
                               "-dtb", dtb_file,
                               "-M", "vexpress-a9"
                           ])
        # It takes quite some time for the system to boot with firewalld.
        self.emulator.login(timeout=120)
        cmd = "firewall-cmd --state"
        output, exit_code = self.emulator.run(cmd, timeout=10)
        self.assertIn("running", output[0])
        self.assertEqual(exit_code, 0)
