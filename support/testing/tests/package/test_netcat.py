import os
import time

import infra.basetest


class TestNetCat(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_NETCAT=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("nc --version")

        msg = "Hello Buildroot!"
        out_file = "output.txt"
        port = 12345

        cmd = f"nc -n -l -p {port} > {out_file} 2> /dev/null &"
        self.assertRunOk(cmd)

        time.sleep(5)

        cmd = f"echo '{msg}' | nc -n -c 127.0.0.1 {port}"
        self.assertRunOk(cmd)

        cmd = f"cat {out_file}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)
