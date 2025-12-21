import os
import time

import infra.basetest


class TestTio(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LUA=y
        BR2_PACKAGE_SOCAT=y
        BR2_PACKAGE_TIO=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def get_tty_name(self):
        out, ret = self.emulator.run("tty")
        self.assertEqual(ret, 0)
        return out[0]

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can run
        self.assertRunOk("tio --version")

        # We save our tty name for later.
        initial_tty = self.get_tty_name()

        # We define two arbitrary pseudo-terminals, for our test.
        pty1 = "pty1_getty"
        pty2 = "pty2_tio"

        # We create our 2 PTYs with socat and connect them together.
        cmd = "( socat"
        for pty in [pty1, pty2]:
            cmd += f" PTY,link=/dev/{pty},rawer,b115200"
        cmd += " &> /dev/null & )"
        self.assertRunOk(cmd)

        # We wait for socat to be ready...
        for attempt in range(3 * self.timeout_multiplier):
            time.sleep(1)
            cmd = f"test -e /dev/{pty1} -a -e /dev/{pty2}"
            _, ret = self.emulator.run(cmd)
            if ret == 0:
                break
        else:
            self.fail("Timeout while waiting for socat.")

        # We start getty on our first PTY.
        self.assertRunOk(f"setsid getty {pty1} 115200 vt100")

        # We start tio on our second PTY and send a new line.
        # We wait for tio to be ready then send a new line.
        # After that, we expect to see a new login.
        self.emulator.qemu.sendline(f"tio /dev/{pty2}")
        self.emulator.qemu.expect(f"Connected to /dev/{pty2}")
        self.emulator.qemu.sendline()

        # We try to re-login, in tio this time.
        self.emulator.login()

        # We get again our tty name.
        tio_tty = self.get_tty_name()

        # We check our second login TTY name is different from the one
        # in the first login.
        self.assertNotEqual(initial_tty, tio_tty)
