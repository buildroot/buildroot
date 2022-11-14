import os

import infra.basetest


class TestAvocado(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_AVOCADO=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()
        cmd = "avocado run /bin/true"
        self.assertRunOk(cmd, timeout=30)
        cmd = "avocado plugins"
        self.assertRunOk(cmd, timeout=30)
