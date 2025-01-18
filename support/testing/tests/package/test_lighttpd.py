import os

import infra.basetest


class TestLighttpd(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LIGHTTPD=y
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

        self.assertRunOk("lighttpd -v")
        self.assertRunOk(f"echo '{msg}' > /var/www/index.html")
        self.assertRunOk("wget http://localhost/index.html")
        self.assertRunOk(f"grep -F '{msg}' index.html")
