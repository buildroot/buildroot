import os

import infra.basetest


class TestGrubi386BIOS(infra.basetest.BRTest):
    config = \
        """
        BR2_x86_core2=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_CORE2_GLIBC_STABLE=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="board/pc/post-build.sh {}"
        BR2_ROOTFS_POST_IMAGE_SCRIPT="support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c board/pc/genimage-bios.cfg"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="4.19.204"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/pc/linux.config"
        BR2_LINUX_KERNEL_INSTALL_TARGET=y
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_I386_PC=y
        BR2_TARGET_GRUB2_INSTALL_TOOLS=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        """.format(infra.filepath("tests/boot/test_grub/post-build.sh"))

    def test_run(self):
        hda = os.path.join(self.builddir, "images", "disk.img")
        self.emulator.boot(arch="i386", options=["-hda", hda])
        self.emulator.login()


class TestGrubi386EFI(infra.basetest.BRTest):
    config = \
        """
        BR2_x86_core2=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_CORE2_GLIBC_STABLE=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="board/pc/post-build.sh {}"
        BR2_ROOTFS_POST_IMAGE_SCRIPT="board/pc/post-image-efi.sh"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="4.19.204"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/pc/linux.config"
        BR2_LINUX_KERNEL_INSTALL_TARGET=y
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_EFIVAR=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_EDK2=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_I386_EFI=y
        BR2_TARGET_GRUB2_INSTALL_TOOLS=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_MTOOLS=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        """.format(infra.filepath("tests/boot/test_grub/post-build.sh"))

    def test_run(self):
        hda = os.path.join(self.builddir, "images", "disk.img")
        bios = os.path.join(self.builddir, "images", "OVMF.fd")
        # In QEMU v5.1.0 up to v7.2.0, the CPU hotplug register block misbehaves.
        # EDK2 hang if the bug is detected in Qemu after printing errors to IO port 0x402
        # (requires BR2_TARGET_EDK2_OVMF_DEBUG_ON_SERIAL to see them)
        # The Docker image used by the Buildroot gitlab-ci uses Qemu 5.2.0, the workaround
        # can be removed as soon as the Docker image is updated to provided Qemu >= 8.0.0.
        # https://github.com/tianocore/edk2/commit/bf5678b5802685e07583e3c7ec56d883cbdd5da3
        # http://lists.busybox.net/pipermail/buildroot/2023-July/670825.html
        qemu_fw_cfg = "name=opt/org.tianocore/X-Cpuhp-Bugcheck-Override,string=yes"
        self.emulator.boot(arch="i386", options=["-bios", bios, "-hda", hda, "-fw_cfg", qemu_fw_cfg])
        self.emulator.login()

        cmd = "modprobe efivarfs"
        self.assertRunOk(cmd)

        cmd = "mount -t efivarfs none /sys/firmware/efi/efivars"
        self.assertRunOk(cmd)

        cmd = "efivar -l"
        self.assertRunOk(cmd)


class TestGrubX8664EFI(infra.basetest.BRTest):
    config = \
        """
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_64_GLIBC_STABLE=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="board/pc/post-build.sh {}"
        BR2_ROOTFS_POST_IMAGE_SCRIPT="board/pc/post-image-efi.sh"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="4.19.204"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/pc/linux.config"
        BR2_LINUX_KERNEL_INSTALL_TARGET=y
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_EFIVAR=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_EDK2=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_X86_64_EFI=y
        BR2_TARGET_GRUB2_INSTALL_TOOLS=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_MTOOLS=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        """.format(infra.filepath("tests/boot/test_grub/post-build.sh"))

    def test_run(self):
        hda = os.path.join(self.builddir, "images", "disk.img")
        bios = os.path.join(self.builddir, "images", "OVMF.fd")
        # In QEMU v5.1.0 up to v7.2.0, the CPU hotplug register block misbehaves.
        # EDK2 hang if the bug is detected in Qemu after printing errors to IO port 0x402
        # (requires BR2_TARGET_EDK2_OVMF_DEBUG_ON_SERIAL to see them)
        # The Docker image used by the Buildroot gitlab-ci uses Qemu 5.2.0, the workaround
        # can be removed as soon as the Docker image is updated to provided Qemu >= 8.0.0.
        # https://github.com/tianocore/edk2/commit/bf5678b5802685e07583e3c7ec56d883cbdd5da3
        # http://lists.busybox.net/pipermail/buildroot/2023-July/670825.html
        qemu_fw_cfg = "name=opt/org.tianocore/X-Cpuhp-Bugcheck-Override,string=yes"
        self.emulator.boot(arch="x86_64", options=["-bios", bios, "-cpu", "Nehalem", "-hda", hda, "-fw_cfg", qemu_fw_cfg])
        self.emulator.login()

        cmd = "modprobe efivarfs"
        self.assertRunOk(cmd)

        cmd = "mount -t efivarfs none /sys/firmware/efi/efivars"
        self.assertRunOk(cmd)

        cmd = "efivar -l"
        self.assertRunOk(cmd)


class TestGrubAArch64EFI(infra.basetest.BRTest):
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_ROOTFS_POST_IMAGE_SCRIPT="{post_image}"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.15.18"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{linux_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_EFIVAR=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_EDK2=y
        BR2_TARGET_GRUB2=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_MTOOLS=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_QEMU=y
        BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=y
        """.format(post_image=infra.filepath("tests/boot/test_grub/post-image-aarch64-efi.sh"),
                   linux_fragment=infra.filepath("tests/boot/test_grub/linux-aarch64-efi.config"))

    def test_run(self):
        hda = os.path.join(self.builddir, "images", "disk.img")
        bios = os.path.join(self.builddir, "images", "QEMU_EFI.fd")
        self.emulator.boot(arch="aarch64", options=["-M", "virt", "-cpu", "cortex-a53", "-bios", bios, "-hda", hda])
        self.emulator.login()

        cmd = "modprobe efivarfs"
        self.assertRunOk(cmd)

        cmd = "mount -t efivarfs none /sys/firmware/efi/efivars"
        self.assertRunOk(cmd)

        cmd = "efivar -l"
        self.assertRunOk(cmd)


class TestGrubRiscV64EFI(infra.basetest.BRTest):
    scripts = [
        "board/qemu/post-image.sh",
        "board/qemu/riscv64-virt-efi/assemble-flash-images",
        "support/scripts/genimage.sh"
    ]
    post_image_script = " ".join(scripts)
    config = \
        f"""
        BR2_riscv=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_ROOTFS_POST_IMAGE_SCRIPT="{post_image_script}"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c board/qemu/riscv64-virt-efi/genimage.cfg"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.59"
        BR2_LINUX_KERNEL_USE_ARCH_DEFAULT_CONFIG=y
        BR2_PACKAGE_EFIVAR=y
        BR2_TARGET_ROOTFS_EXT2=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_EDK2=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_RISCV64_EFI=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_MTOOLS=y
        BR2_PACKAGE_HOST_QEMU=y
        BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=y
        """

    def test_run(self):
        disk = os.path.join(self.builddir, "images", "disk.img")
        flash0 = os.path.join(self.builddir, "images", "RISCV_VIRT_CODE.fd")
        flash1 = os.path.join(self.builddir, "images", "RISCV_VIRT_VARS.fd")
        qemu_opts = [
            "-M", "virt,pflash0=pflash0,pflash1=pflash1,acpi=off",
            "-blockdev", f"node-name=pflash0,driver=file,read-only=on,filename={flash0}",
            "-blockdev", f"node-name=pflash1,driver=file,filename={flash1}",
            "-drive", f"file={disk},format=raw,if=virtio"
        ]
        self.emulator.boot(arch="riscv64", options=qemu_opts)
        self.emulator.login()

        cmd = "mount -t efivarfs none /sys/firmware/efi/efivars"
        self.assertRunOk(cmd)

        cmd = "efivar -l"
        self.assertRunOk(cmd)
