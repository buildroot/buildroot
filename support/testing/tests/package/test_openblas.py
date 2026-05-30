import os

import infra.basetest


class TestOpenBLAS(infra.basetest.BRTest):
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.27"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_OPENBLAS=y
        BR2_PACKAGE_OPENBLAS_INSTALL_TESTS=y
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-smp", "2", "-m", "512M", "-initrd", img])
        self.emulator.login()

        test_prefix = "/usr/libexec/openblas/tests"

        # BLAS data types:
        blas_data_types = [
            "s",  # Single precision (32bit) float
            "d",  # Double precision (64bit) double
            "c",  # Single precision (32bit) complex
            "z"   # Double precision (64bit) complex
        ]

        # BLAS routine levels:
        # Level 1: Vector operations,
        # Level 2: Matrix-Vector operations,
        # Level 3: Matrix-Matrix operations.
        for blas_level in range(1, 4):
            for blas_data_type in blas_data_types:
                test_name = f"x{blas_data_type}cblat{blas_level}"
                cmd = test_prefix + "/" + test_name

                if blas_level > 1:
                    cmd += f" < {test_prefix}/{blas_data_type}in{blas_level}"

                self.assertRunOk(cmd, timeout=30)
