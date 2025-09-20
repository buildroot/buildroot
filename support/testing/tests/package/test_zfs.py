import os

import infra.basetest


class TestZfsBase(infra.basetest.BRTest):
    timeout = 60 * 3
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.9"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_ZFS=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_CFFI=y
        BR2_PACKAGE_PYTHON_SETUPTOOLS=y
        BR2_PACKAGE_ZLIB_NG=y
        BR2_PACKAGE_LIBRESSL=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def base_test_run(self):
        kernel = os.path.join(self.builddir, "images", "Image")
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(
            arch="aarch64",
            kernel=kernel,
            kernel_cmdline=["console=ttyAMA0"],
            options=["-M", "virt", "-cpu", "cortex-a57", "-m", "320M",
                     "-initrd", cpio_file],
        )
        self.emulator.login()

        cmds = [
            # Init
            "modprobe zfs && sleep 2",
            "mount -o remount,size=132M /tmp",
            "fallocate -l 64M /tmp/container1.raw",
            "fallocate -l 64M /tmp/container2.raw",
            "zpool create pool raidz /tmp/container1.raw /tmp/container2.raw",
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
            self.assertRunOk(cmd, timeout=self.timeout)


class TestZfsGlibc(TestZfsBase):
    config = TestZfsBase.config + \
        """
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_AARCH64_GLIBC_STABLE=y
        """

    def test_run(self):
        TestZfsBase.base_test_run(self)


class TestZfsUclibc(TestZfsBase):
    # The Bootling aarch64 uclibc stable 2025.08-1 needs to be
    # rebuild with uClibc-ng 1.0.55.
    # See: https://github.com/wbx-github/uclibc-ng/commit/94c1297d52263e20cd9715601afa37f49d008d93
    config = TestZfsBase.config.replace('BR2_TOOLCHAIN_EXTERNAL=y\n', '')
    config = config.replace('BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y\n', '') + \
        """
        BR2_TOOLCHAIN_BUILDROOT_UCLIBC=y
        BR2_KERNEL_HEADERS_5_4=y
        BR2_TOOLCHAIN_BUILDROOT_LOCALE=y
        BR2_PTHREAD_DEBUG=y
        BR2_TOOLCHAIN_BUILDROOT_CXX=y
        BR2_GCC_ENABLE_OPENMP=y
        """

    def test_run(self):
        TestZfsBase.base_test_run(self)


class TestZfsMusl(TestZfsBase):
    config = TestZfsBase.config + \
        """
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_AARCH64_MUSL_STABLE=y
        """

    def test_run(self):
        TestZfsBase.base_test_run(self)
