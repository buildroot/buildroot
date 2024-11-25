import os

import infra.basetest


class TestDtc(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_DTC=y
        BR2_PACKAGE_DTC_PROGRAMS=y
        BR2_ROOTFS_OVERLAY="{}"
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_ROOTFS_CPIO=y
        """.format(
           # overlay to add a bats test suite
           infra.filepath("tests/package/test_dtc/rootfs-overlay"))

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])

        self.emulator.login()

        # Test 'dtc'
        self.assertRunOk("dtc -I dts -O dtb -o /tmp/test_tree1.dtb /test_tree1.dts")

        # Test 'fdtdump'
        self.assertRunOk("fdtdump /tmp/test_tree1.dtb")

        # Test 'fdtget'
        out, exit_code = self.emulator.run("fdtget -t s /tmp/test_tree1.dtb / compatible")
        self.assertEqual(out[0].strip(), "test_tree1")

        # Test 'fdtput'
        self.assertRunOk("fdtput -t s /tmp/test_tree1.dtb / compatible 'test set compatible'")
        out, exit_code = self.emulator.run("fdtget -t s /tmp/test_tree1.dtb / compatible")
        self.assertEqual(out[0].strip(), "test set compatible")
