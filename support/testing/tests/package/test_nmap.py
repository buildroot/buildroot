import os
import time

import infra.basetest


class TestNmap(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_NMAP=y
        BR2_PACKAGE_NMAP_NCAT=y
        BR2_PACKAGE_NMAP_NMAP=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("nmap --version")

        # We open few ports, using the nmap netcat "nc" commands.
        ports = [21, 23, 25, 80]
        for port in ports:
            cmd = f"nc -l -p {port} </dev/null &>/dev/null &"
            self.assertRunOk(cmd)

        time.sleep(1 * self.timeout_multiplier)

        # We run a local port scan. We should see in the output the
        # ports we previously opened.
        out, ret = self.emulator.run("nmap -n -sS 127.0.0.1", timeout=20)
        self.assertEqual(ret, 0)
        nmap_out = "\n".join(out)
        for port in ports:
            self.assertRegex(nmap_out, f"{port}/tcp *open")
