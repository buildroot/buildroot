import os

import infra.basetest


class TestFlatStackSize(infra.basetest.BRTest):
    br2_external = [infra.filepath("tests/core/br2-external/flat-stacksize")]
    config = """
        BR2_arm=y
        BR2_cortex_m4=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARMV7M_UCLIBC_STABLE=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_FLAT_STACKSIZE_TEST=y
        """

    def test_run(self):
        binary = os.path.join(
            self.builddir, "target", "usr", "bin", "flat_stacksize_test"
        )
        self.assertTrue(os.path.exists(binary))

        # Check the FLAT binary header really carries the stack size
        # declared by the package (8192 = 0x2000).
        out = infra.run_cmd_on_host(self.builddir, ["arm-linux-flthdr", binary])
        self.assertIn("Stack Size:   0x2000\n", out)
