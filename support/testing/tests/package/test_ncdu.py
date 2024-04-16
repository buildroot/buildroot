import os

import infra.basetest


class TestNcdu(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_NCDU=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("ncdu --version")
        self.assertRunOk("ncdu -x -o /tmp/ncdu.list /")
        self.assertRunOk("grep -F '\"name\":\"ncdu\"' /tmp/ncdu.list")
