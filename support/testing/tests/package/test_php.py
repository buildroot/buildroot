import os

import infra.basetest


class TestPhp(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_php/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_APACHE=y
        BR2_PACKAGE_LIBCURL=y
        BR2_PACKAGE_LIBCURL_CURL=y
        BR2_PACKAGE_PHP=y
        BR2_PACKAGE_PHP_SAPI_APACHE=y
        BR2_PACKAGE_PHP_SAPI_CLI=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the php program can execute.
        self.assertRunOk("php --version")

        # We check can print a message from the command line.
        msg = "Hello Buildroot!"
        php_code = f"echo '{msg}' . PHP_EOL;"
        cmd = f"php -r \"{php_code}\""
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

        # We check we can exit with a specific code.
        exit_code = 123
        php_code = f"exit({exit_code});"
        cmd = f"php -r \"{php_code}\""
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, exit_code)
        self.assertEqual(len(out), 0)

        # We check we can run a slightly more complex program.
        self.assertRunOk("php mandel.php")

        # We check the apache php module is also working.
        # The php script reads the "message" POST variable,
        # then write its content back in upper case.
        cmd = "curl"
        cmd += " -H 'Content-type: multipart/form-data'"
        cmd += " -X POST"
        cmd += f" -F message='{msg}'"
        cmd += " http://127.0.0.1/script.php"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual("\n".join(out), msg.upper())
