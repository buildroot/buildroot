import os

import infra.basetest


class TestZfsGlibc(infra.basetest.BRTest):
    config = \
        """
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_64_CORE_I7_GLIBC_STABLE=y
        BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.12.13"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86_64/linux.config"
        BR2_PACKAGE_ZFS=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_CFFI=y
        BR2_PACKAGE_PYTHON_SETUPTOOLS=y
        BR2_PACKAGE_ZLIB_NG=y
        BR2_PACKAGE_LIBRESSL=y
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
            options=["-cpu", "Nehalem", "-m", "320", "-initrd", cpio_file],
        )
        self.emulator.login()

        cmds = [
            # Init
            "modprobe zfs",
            "mount -o remount,size=132M /tmp",
            "fallocate -l 64M /tmp/container1.raw",
            "fallocate -l 64M /tmp/container2.raw",
            "zpool create -m /pool pool raidz /tmp/container1.raw /tmp/container2.raw",
            "dd if=/dev/urandom bs=1M count=8 of=/pool/urandom",
            "sha256sum /pool/urandom > /tmp/urandom.sha256",
            # Check ZFS
            "zpool export pool",
            "zpool import pool -d /tmp/container1.raw -d /tmp/container2.raw",
            "dd conv=notrunc bs=1M count=32 seek=16 if=/dev/urandom of=/tmp/container1.raw",
            "zpool scrub -w pool",
            "sha256sum -c /tmp/urandom.sha256",
            "zpool status -v",
            # Check PyZFS
            "arc_summary",
        ]
        for cmd in cmds:
            self.assertRunOk(cmd)


class TestZfsUclibc(infra.basetest.BRTest):
    config = \
        """
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_64_CORE_I7_UCLIBC_STABLE=y
        BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.12.13"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86_64/linux.config"
        BR2_PACKAGE_ZFS=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_CFFI=y
        BR2_PACKAGE_PYTHON_SETUPTOOLS=y
        BR2_PACKAGE_ZLIB_NG=y
        BR2_PACKAGE_LIBRESSL=y
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
            options=["-cpu", "Nehalem", "-m", "320", "-initrd", cpio_file],
        )
        self.emulator.login()

        cmds = [
            # Init
            "modprobe zfs",
            "mount -o remount,size=132M /tmp",
            "fallocate -l 64M /tmp/container1.raw",
            "fallocate -l 64M /tmp/container2.raw",
            "zpool create -m /pool pool raidz /tmp/container1.raw /tmp/container2.raw",
            "dd if=/dev/urandom bs=1M count=8 of=/pool/urandom",
            "sha256sum /pool/urandom > /tmp/urandom.sha256",
            # Check ZFS
            "zpool export pool",
            "zpool import pool -d /tmp/container1.raw -d /tmp/container2.raw",
            "dd conv=notrunc bs=1M count=32 seek=16 if=/dev/urandom of=/tmp/container1.raw",
            "zpool scrub -w pool",
            "sha256sum -c /tmp/urandom.sha256",
            "zpool status -v",
            # Check PyZFS
            "arc_summary",
        ]
        for cmd in cmds:
            self.assertRunOk(cmd)
