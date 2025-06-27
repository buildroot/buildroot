import os

import infra.basetest


class TestNginxModsecurity(infra.basetest.BRTest):
    overlay = infra.filepath("tests/package/test_nginx_modsecurity/overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_NGINX=y
        BR2_PACKAGE_NGINX_HTTP=y
        BR2_PACKAGE_NGINX_MODSECURITY=y
        BR2_ROOTFS_OVERLAY="{overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("nginx -V")
        self.assertRunOk("wget http://localhost/index.html")
        self.assertRunOk("grep -F 'Welcome to nginx!' index.html")
        cmd = "wget -q -O /dev/null --server-response 2>&1 " \
            "http://localhost/blockme/ 2>&1 | awk '/^  HTTP/{print $2}'"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        # Check for HTTP 403 Unauthorized:
        self.assertEqual(out[0], "403")
