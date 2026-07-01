import os

import infra
import infra.basetest


class TestApache(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_APACHE=y
        BR2_TARGET_ROOTFS_SQUASHFS=y
        BR2_TARGET_ROOTFS_SQUASHFS4_LZO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        rootfs = os.path.join(self.builddir, "images", "rootfs.squashfs")
        infra.img_round_power2(rootfs)
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           kernel_cmdline=["root=/dev/mmcblk0",
                                           "rootfstype=squashfs"],
                           options=["-drive",
                                    "file={},if=sd,format=raw".format(rootfs)])
        self.emulator.login()

        self.assertRunOk("httpd -V")
        self.assertRunOk("wget -O /tmp/index.html http://localhost/index.html")
        self.assertRunOk("grep -F 'It works!' /tmp/index.html")
