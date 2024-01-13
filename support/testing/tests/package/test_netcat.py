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

        in_file = "input.bin"
        out_file = "output.bin"
        port = 12345

        cmd = f"dd if=/dev/urandom of={in_file} bs=1k count=1k"
        self.assertRunOk(cmd)

        cmd = f"nc -l -p {port} > {out_file} &"
        self.assertRunOk(cmd)

        time.sleep(1)

        cmd = f"cat {in_file} | nc -c 127.0.0.1 {port}"
        self.assertRunOk(cmd)

        cmd = f"cmp {in_file} {out_file}"
        self.assertRunOk(cmd)
