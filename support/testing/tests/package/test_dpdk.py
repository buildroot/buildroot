import os

import infra.basetest


class TestDPDK(infra.basetest.BRTest):
    config = \
        """
        BR2_x86_64=y
        BR2_x86_nehalem=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.102"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86_64/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_DPDK=y
        BR2_PACKAGE_DPDK_TESTS=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="300M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.ext2")
        kern = os.path.join(self.builddir, "images", "bzImage")
        self.emulator.boot(arch="x86_64",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda", "console=ttyS0"],
                           options=["-cpu", "Nehalem", "-m", "512M",
                                    "-smp", "4",
                                    "-device", "virtio-rng-pci",
                                    "-drive", f"file={img},format=raw,if=virtio",
                                    "-net", "nic,model=virtio",
                                    "-net", "user"])
        self.emulator.login()

        # We run few DPDK test cases.
        dpdk_tests = [
            "crc_autotest",
            "threads_autotest",
            "lcores_autotest"
        ]
        cmd = "dpdk-test --no-huge " + " ".join(dpdk_tests)
        self.assertRunOk(cmd, timeout=30)
