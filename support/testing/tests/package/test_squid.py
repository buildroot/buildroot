import os
import time

import infra.basetest


class TestSquid(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_LIGHTTPD=y
        BR2_PACKAGE_SQUID=y
        BR2_PACKAGE_WGET=y
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

        # We check the program can run.
        self.assertRunOk("squid --version")

        # We create a file to serve over http.
        self.assertRunOk(f"echo '{msg}' > /var/www/{fname}")

        # We download the test file through the proxy.
        proxy = "http://127.0.0.1:3128"
        url = f"http://localhost/{fname}"
        cmd = f"wget --progress=dot -e http_proxy={proxy} {url}"
        # The squid server can take some time to start. Depending the
        # load of the test controller, this can take a variable amount
        # of time. We attempt several time before failing.
        for attempt in range(15):
            time.sleep(5)

            _, ret = self.emulator.run(cmd)
            if ret == 0:
                break
            # wget exit with status code 4 in case of a network error.
            # Since we are waiting for the proxy server to be ready,
            # we only expect this kind of error. We fail for other
            # types of error.
            self.assertEqual(ret, 4)
        else:
            self.fail("Timeout while waiting for squid to be ready.")

        # We check the downloaded file has the expected content.
        cmd = f"cat {fname}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)

        # We also check the squid proxy logged the access.
        cmd = "cat /var/log/squid/access.log"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        log_str = f"GET {url}"
        self.assertIn(log_str, "\n".join(out))
