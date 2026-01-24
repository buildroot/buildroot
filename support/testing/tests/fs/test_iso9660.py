import os

import infra.basetest

BASIC_CONFIG = \
    """
    BR2_x86_core2=y
    BR2_TOOLCHAIN_EXTERNAL=y
    BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_CORE2_GLIBC_STABLE=y
    BR2_TARGET_GENERIC_GETTY_PORT="ttyS0"
    BR2_TARGET_GENERIC_GETTY_BAUDRATE_115200=y
    BR2_LINUX_KERNEL=y
    BR2_LINUX_KERNEL_CUSTOM_VERSION=y
    BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="4.19.204"
    BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
    BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="{}"
    # BR2_TARGET_ROOTFS_TAR is not set
    """.format(infra.filepath("conf/minimal-x86-qemu-kernel.config"))


def test_mount_internal_external(emulator, builddir, internal=True):
    img = os.path.join(builddir, "images", "rootfs.iso9660")
    emulator.boot(arch="i386", options=["-cdrom", img])
    emulator.login()

    if internal:
        cmd = "mount | grep 'rootfs on / type rootfs'"
    else:
        cmd = "mount | grep '/dev/root on / type iso9660'"

    _, exit_code = emulator.run(cmd)
    return exit_code


def test_touch_file(emulator):
    _, exit_code = emulator.run("touch test")
    return exit_code

#
# Grub 2


class TestIso9660Grub2External(infra.basetest.BRTest):
    config = BASIC_CONFIG + \
        """
        BR2_TARGET_ROOTFS_ISO9660=y
        # BR2_TARGET_ROOTFS_ISO9660_INITRD is not set
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_BOOT_PARTITION="cd"
        BR2_TARGET_GRUB2_BUILTIN_MODULES_PC="boot linux ext2 fat part_msdos part_gpt normal biosdisk iso9660"
        BR2_TARGET_ROOTFS_ISO9660_BOOT_MENU="{}"
        """.format(infra.filepath("conf/grub2.cfg"))

    def test_run(self):
        exit_code = test_mount_internal_external(self.emulator,
                                                 self.builddir, internal=False)
        self.assertEqual(exit_code, 0)

        exit_code = test_touch_file(self.emulator)
        self.assertEqual(exit_code, 1)


class TestIso9660Grub2ExternalCompress(infra.basetest.BRTest):
    config = BASIC_CONFIG + \
        """
        BR2_TARGET_ROOTFS_ISO9660=y
        # BR2_TARGET_ROOTFS_ISO9660_INITRD is not set
        BR2_TARGET_ROOTFS_ISO9660_TRANSPARENT_COMPRESSION=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_BOOT_PARTITION="cd"
        BR2_TARGET_GRUB2_BUILTIN_MODULES_PC="boot linux ext2 fat part_msdos part_gpt normal biosdisk iso9660"
        BR2_TARGET_ROOTFS_ISO9660_BOOT_MENU="{}"
        """.format(infra.filepath("conf/grub2.cfg"))

    def test_run(self):
        exit_code = test_mount_internal_external(self.emulator,
                                                 self.builddir, internal=False)
        self.assertEqual(exit_code, 0)

        exit_code = test_touch_file(self.emulator)
        self.assertEqual(exit_code, 1)


class TestIso9660Grub2Internal(infra.basetest.BRTest):
    config = BASIC_CONFIG + \
        """
        BR2_TARGET_ROOTFS_ISO9660=y
        BR2_TARGET_ROOTFS_ISO9660_INITRD=y
        BR2_TARGET_GRUB2=y
        BR2_TARGET_GRUB2_BOOT_PARTITION="cd"
        BR2_TARGET_GRUB2_BUILTIN_MODULES_PC="boot linux ext2 fat part_msdos part_gpt normal biosdisk iso9660"
        BR2_TARGET_ROOTFS_ISO9660_BOOT_MENU="{}"
        """.format(infra.filepath("conf/grub2.cfg"))

    def test_run(self):
        exit_code = test_mount_internal_external(self.emulator,
                                                 self.builddir, internal=True)
        self.assertEqual(exit_code, 0)

        exit_code = test_touch_file(self.emulator)
        self.assertEqual(exit_code, 0)


#
# Syslinux


class TestIso9660SyslinuxExternal(infra.basetest.BRTest):
    config = BASIC_CONFIG + \
        """
        BR2_TARGET_ROOTFS_ISO9660=y
        # BR2_TARGET_ROOTFS_ISO9660_INITRD is not set
        BR2_TARGET_ROOTFS_ISO9660_HYBRID=y
        BR2_TARGET_ROOTFS_ISO9660_BOOT_MENU="{}"
        BR2_TARGET_SYSLINUX=y
        """.format(infra.filepath("conf/isolinux.cfg"))

    def test_run(self):
        exit_code = test_mount_internal_external(self.emulator,
                                                 self.builddir, internal=False)
        self.assertEqual(exit_code, 0)

        exit_code = test_touch_file(self.emulator)
        self.assertEqual(exit_code, 1)


class TestIso9660SyslinuxExternalCompress(infra.basetest.BRTest):
    config = BASIC_CONFIG + \
        """
        BR2_TARGET_ROOTFS_ISO9660=y
        # BR2_TARGET_ROOTFS_ISO9660_INITRD is not set
        BR2_TARGET_ROOTFS_ISO9660_TRANSPARENT_COMPRESSION=y
        BR2_TARGET_ROOTFS_ISO9660_HYBRID=y
        BR2_TARGET_ROOTFS_ISO9660_BOOT_MENU="{}"
        BR2_TARGET_SYSLINUX=y
        """.format(infra.filepath("conf/isolinux.cfg"))

    def test_run(self):
        exit_code = test_mount_internal_external(self.emulator,
                                                 self.builddir, internal=False)
        self.assertEqual(exit_code, 0)

        exit_code = test_touch_file(self.emulator)
        self.assertEqual(exit_code, 1)


class TestIso9660SyslinuxInternal(infra.basetest.BRTest):
    config = BASIC_CONFIG + \
        """
        BR2_TARGET_ROOTFS_ISO9660=y
        BR2_TARGET_ROOTFS_ISO9660_INITRD=y
        BR2_TARGET_ROOTFS_ISO9660_HYBRID=y
        BR2_TARGET_ROOTFS_ISO9660_BOOT_MENU="{}"
        BR2_TARGET_SYSLINUX=y
        """.format(infra.filepath("conf/isolinux.cfg"))

    def test_run(self):
        exit_code = test_mount_internal_external(self.emulator,
                                                 self.builddir, internal=True)
        self.assertEqual(exit_code, 0)

        exit_code = test_touch_file(self.emulator)
        self.assertEqual(exit_code, 0)
