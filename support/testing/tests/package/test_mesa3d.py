import os
import infra.basetest

RUSTICL_TIMEOUT = 180


class TestMesa3DRusticl(infra.basetest.BRTest):
    config = """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.12.31"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_PACKAGE_MESA3D=y
        BR2_PACKAGE_MESA3D_LLVM=y
        BR2_PACKAGE_MESA3D_OPENCL=y
        BR2_PACKAGE_MESA3D_RUSTICL=y
        BR2_PACKAGE_MESA3D_GALLIUM_DRIVER_LLVMPIPE=y
        BR2_PACKAGE_CLINFO=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="1024M"
        # BR2_TARGET_ROOTFS_TAR is not set
    """

    def login(self):
        img = os.path.join(self.builddir, "images", "rootfs.ext2")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(
            arch="aarch64",
            kernel=kern,
            kernel_cmdline=["root=/dev/vda console=ttyAMA0"],
            options=[
                "-M", "virt",
                "-cpu", "cortex-a57",
                "-m", "512",
                "-drive", f"file={img},if=virtio,format=raw"
            ]
        )
        self.emulator.login()

    def test_run(self):
        self.login()

        # check the output exit code
        output, exit_code = self.emulator.run("RUSTICL_ENABLE=llvmpipe clinfo", RUSTICL_TIMEOUT)
        self.assertEqual(exit_code, 0)
        # also check if platform name is rusticl and device name is llvmpipe
        self.assertRegex("\n".join(output), r"Platform Name\s+rusticl")
        self.assertRegex("\n".join(output), r"Device Name\s+llvmpipe")
