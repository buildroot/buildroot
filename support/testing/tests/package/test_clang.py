import os

import infra.basetest

FUZZ_TIMEOUT = 120


class TestClangCompilerRT(infra.basetest.BRTest):
    br2_external = [infra.filepath("tests/package/br2-external/clang-compiler-rt")]
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="4.19.283"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_COMPILER_RT=y
        BR2_PACKAGE_LLVM=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_LIBFUZZER=y
        """

    def login(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        # Sanitizers overallocate memory and the minimum that seemed to work was 512MB
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a53", "-m", "512", "-initrd", img])
        self.emulator.login()

    def test_run(self):
        self.login()

        # The test case verifies the application executes and that
        # the symbolizer is working to decode the stack trace.
        cmd = "fuzz_me 2>&1 | grep heap-buffer-overflow"
        _, exit_code = self.emulator.run(cmd, FUZZ_TIMEOUT)
        self.assertEqual(exit_code, 0)
