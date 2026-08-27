import os

import infra.basetest


class TestHaproxy(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_ROOTFS_POST_BUILD_SCRIPT="{}"
        BR2_ROOTFS_POST_SCRIPT_ARGS="{}"
        BR2_PACKAGE_HAPROXY=y
        BR2_PACKAGE_LIGHTTPD=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
            infra.filepath("tests/package/copy-sample-script-to-target.sh"),
            infra.filepath("conf/haproxy.cfg")
        )

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        msg = "Hello Buildroot!"

        # sanity check
        self.assertRunOk("haproxy -v")
        self.assertRunOk("haproxy -c -f .")

        # proxy to lighttpd
        self.assertRunOk("haproxy -D -f .")

        self.assertRunOk(f"echo '{msg}' > /var/www/index.html")
        self.assertRunOk("wget http://localhost:81/index.html")
        self.assertRunOk(f"grep -F '{msg}' index.html")
