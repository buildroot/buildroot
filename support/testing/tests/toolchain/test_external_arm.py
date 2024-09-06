from tests.toolchain.test_external import TestExternalToolchain


class TestExternalToolchainArmArm(TestExternalToolchain):
    config = """
        BR2_arm=y
        BR2_cortex_a8=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_ARM_ARM=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "arm-none-linux-gnueabihf"

    def test_run(self):
        TestExternalToolchain.common_check(self)


class TestExternalToolchainArmAarch64(TestExternalToolchain):
    config = """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_ARM_AARCH64=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "aarch64-none-linux-gnu"

    def test_run(self):
        TestExternalToolchain.common_check(self)


class TestExternalToolchainArmAarch64Be(TestExternalToolchain):
    config = """
        BR2_aarch64_be=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_ARM_AARCH64_BE=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "aarch64_be-none-linux-gnu"

    def test_run(self):
        TestExternalToolchain.common_check(self)
