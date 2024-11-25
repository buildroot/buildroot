from tests.toolchain.test_external import TestExternalToolchain


class TestExternalToolchainSynopsysArc700LE(TestExternalToolchain):
    config = """
        BR2_arcle=y
        BR2_arc770d=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC700=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "arc-linux"

    def test_run(self):
        TestExternalToolchain.common_check(self)


class TestExternalToolchainSynopsysArc700BE(TestExternalToolchain):
    config = """
        BR2_arceb=y
        BR2_arc770d=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC700=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "arceb-linux"

    def test_run(self):
        TestExternalToolchain.common_check(self)


class TestExternalToolchainSynopsysArcHSGlibcLE(TestExternalToolchain):
    config = """
        BR2_arcle=y
        BR2_archs38_full=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARCHS_GLIBC=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "arc-linux"

    def test_run(self):
        TestExternalToolchain.common_check(self)


class TestExternalToolchainSynopsysArcHSGlibcBE(TestExternalToolchain):
    config = """
        BR2_arceb=y
        BR2_archs38_full=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARCHS_GLIBC=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "arceb-linux"

    def test_run(self):
        TestExternalToolchain.common_check(self)


class TestExternalToolchainSynopsysArcHSuClibcLE(TestExternalToolchain):
    config = """
        BR2_arcle=y
        BR2_archs38_full=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARCHS_UCLIBC=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "arc-linux"

    def test_run(self):
        TestExternalToolchain.common_check(self)


class TestExternalToolchainSynopsysArcHSuClibcBE(TestExternalToolchain):
    config = """
        BR2_arceb=y
        BR2_archs38_full=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARC=y
        BR2_TOOLCHAIN_EXTERNAL_SYNOPSYS_ARCHS_UCLIBC=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    toolchain_prefix = "arceb-linux"

    def test_run(self):
        TestExternalToolchain.common_check(self)
