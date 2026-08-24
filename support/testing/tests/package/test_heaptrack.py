import os

import infra.basetest


class TestHeaptrack(infra.basetest.BRTest):
    # infra.basetest.BASIC_TOOLCHAIN_CONFIG cannot be used as it does
    # not include BR2_TOOLCHAIN_SUPPORTS_ALWAYS_LOCKFREE_ATOMIC_INTS
    # needed by heaptrack.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.42"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_HEAPTRACK=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_ROOTFS_CPIO=y
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-m", "256M",
                                    "-initrd", cpio_file])

        self.emulator.login()

        self.assertRunOk("/usr/bin/heaptrack --version")
        self.assertRunOk("/usr/bin/heaptrack /bin/busybox")
        self.assertRunOk("/usr/bin/heaptrack -o /tmp/ls.heaptrack ls -al /")
        self.assertRunOk("/usr/bin/heaptrack_print --file /tmp/ls.heaptrack.gz")
