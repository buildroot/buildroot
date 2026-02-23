import os

import infra.basetest


class TestConnMan(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_CONNMAN=y
        BR2_PACKAGE_CONNMAN_CLIENT=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can execute.
        self.assertRunOk("connmand --version")

        # We query the connman state and expect it to be ready.
        out, ret = self.emulator.run("connmanctl state")
        out_str = "\n".join(out)
        self.assertEqual(ret, 0)
        self.assertIn("State = ready", out_str)

        # We list the technologies and expect to see at least Ethernet
        # because the emulator has one interface.
        out, ret = self.emulator.run("connmanctl technologies")
        out_str = "\n".join(out)
        self.assertEqual(ret, 0)
        self.assertIn("Type = ethernet", out_str)

        # We ping the qemu user networking gateway. The startup
        # scripts should have brought up the interface, so the ping
        # is expected to succeed.
        ping_cmd = "ping -c 3 -i 0.2 -W 2 10.0.2.2"
        self.assertRunOk(ping_cmd)

        # Now, we ask connman to disable Ethernet. It should stop the
        # interface.
        self.assertRunOk("connmanctl disable ethernet")

        # If we try to ping again the qemu gateway,
        # it should now fail.
        _, ret = self.emulator.run(ping_cmd)
        self.assertNotEqual(ret, 0)

        # We ask connman to re-enable Ethernet.
        self.assertRunOk("connmanctl enable ethernet")

        # We should be able to ping the qemu gateway again.
        self.assertRunOk(ping_cmd)
