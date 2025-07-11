import infra.basetest


class TestSysLinuxBase(infra.basetest.BRTest):
    x86_toolchain_config = \
        """
        BR2_x86_i686=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_I686_GLIBC_BLEEDING_EDGE=y
        """

    x86_64_toolchain_config = \
        """
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_64_CORE_I7_GLIBC_BLEEDING_EDGE=y
        """

    syslinux_legacy_config = \
        """
        BR2_TARGET_SYSLINUX=y
        BR2_TARGET_SYSLINUX_ISOLINUX=y
        BR2_TARGET_SYSLINUX_PXELINUX=y
        BR2_TARGET_SYSLINUX_MBR=y
        """

    syslinux_efi_config = \
        """
        BR2_TARGET_SYSLINUX=y
        BR2_TARGET_SYSLINUX_EFI=y
        """


class TestSysLinuxX86LegacyBios(TestSysLinuxBase):
    config = \
        TestSysLinuxBase.x86_toolchain_config + \
        infra.basetest.MINIMAL_CONFIG + \
        TestSysLinuxBase.syslinux_legacy_config

    def test_run(self):
        pass


class TestSysLinuxX86EFI(TestSysLinuxBase):
    config = \
        TestSysLinuxBase.x86_toolchain_config + \
        infra.basetest.MINIMAL_CONFIG + \
        TestSysLinuxBase.syslinux_efi_config

    def test_run(self):
        pass


class TestSysLinuxX86_64LegacyBios(TestSysLinuxBase):
    config = \
        TestSysLinuxBase.x86_64_toolchain_config + \
        infra.basetest.MINIMAL_CONFIG + \
        TestSysLinuxBase.syslinux_legacy_config

    def test_run(self):
        pass


class TestSysLinuxX86_64EFI(TestSysLinuxBase):
    config = \
        TestSysLinuxBase.x86_64_toolchain_config + \
        infra.basetest.MINIMAL_CONFIG + \
        TestSysLinuxBase.syslinux_efi_config

    def test_run(self):
        pass
