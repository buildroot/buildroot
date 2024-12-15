import os

import infra.basetest


class TestLibCurl(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LIBCURL=y
        BR2_PACKAGE_LIBCURL_CURL=y
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
        fname = "file.txt"
        url = f"http://localhost/{fname}"

        # We check the program can execute.
        self.assertRunOk("curl --version")

        # We create a simple file to serve.
        self.assertRunOk(f"echo '{msg}' > /var/www/data/{fname}")

        # We try to download that file, using our local httpd server.
        self.assertRunOk(f"curl -o {fname} {url}")

        # We check the downloaded file contains our initial message.
        out, ret = self.emulator.run(f"cat {fname}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

        # We download again the file without saving it, but printing
        # it on stdout this time.
        out, ret = self.emulator.run(f"curl -q {url}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

        # We download one last time, showing the server response. We
        # check we can see the OK status and our thttpd server
        # identification.
        cmd = f"curl --no-progress-meter --dump-header - -o /dev/null {url}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        out_str = "\n".join(out)
        self.assertIn("HTTP/1.1 200 OK", out_str)
        self.assertIn("Server: thttpd/", out_str)
