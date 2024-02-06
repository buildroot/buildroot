import os

import infra.basetest


class TestThttpd(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_THTTPD=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        msg = "Hello Buildroot!"

        self.assertRunOk("thttpd -V")
        self.assertRunOk(f"echo '{msg}' > /var/www/data/index.html")
        self.assertRunOk("wget http://localhost/index.html")
        self.assertRunOk(f"grep -F '{msg}' index.html")
