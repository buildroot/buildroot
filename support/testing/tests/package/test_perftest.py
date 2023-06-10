import os

import infra.basetest


class TestPerftest(infra.basetest.BRTest):

    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.33"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_IPROUTE2=y
        BR2_PACKAGE_LIBMNL=y
        BR2_PACKAGE_RDMA_CORE=y
        BR2_PACKAGE_PERFTEST=y
        """.format(
            infra.filepath("tests/package/test_rdma_core/linux-rdma.fragment")
        )

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "512M", "-initrd", img])
        self.emulator.login()

        # Add the rxe0 interface
        self.assertRunOk("ip link set dev eth0 up")
        self.assertRunOk("rdma link add rxe0 type rxe netdev eth0")

        # start a server
        self.assertRunOk("ib_read_bw > /dev/null 2>&1 &")

        # start a client
        self.assertRunOk("sleep 1 && ib_read_bw 127.0.0.1")
