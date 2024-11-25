import os

import infra.basetest


class TestBats(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_ENABLE_LOCALE_WHITELIST=""
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_BASH=y
        BR2_PACKAGE_BATS_CORE=y
        BR2_PACKAGE_BATS_ASSERT=y
        BR2_PACKAGE_BATS_FILE=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
           # overlay to add a bats test suite
           infra.filepath("tests/package/test_bats/rootfs-overlay"))

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("bats --version")

        self.assertRunOk("bats /root/test-bats-core.bats", timeout=5)
        self.assertRunOk("bats /root/test-bats-assert.bats", timeout=5)
        self.assertRunOk("bats /root/test-bats-file.bats", timeout=5)
