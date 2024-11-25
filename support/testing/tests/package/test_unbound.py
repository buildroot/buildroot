import os

import infra.basetest


class TestUnbound(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_unbound/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_UNBOUND=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
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
        self.assertRunOk("unbound -V")

        # Verify that the configuration checker validates our file.
        self.assertRunOk("unbound-checkconf")

        # Our test configuration enabled the unbound remote
        # control. The unbound server is supposed to be started by the
        # sysv initscript. We should see the already running server.
        out, ret = self.emulator.run("unbound-control status")
        self.assertEqual(ret, 0)
        self.assertRegex("\n".join(out), r"unbound \(pid \d+\) is running")

        # We check the "unbound-host" program is working with a simple
        # query. Note: this local query succeed even if the unbound
        # server is not running. We are only testing this program
        # here. The server side will be tested with the BusyBox
        # "nslookup" applet.
        out, ret = self.emulator.run("unbound-host -t A localhost.")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "localhost. has address 127.0.0.1")

        # We test few other "unbound-control" commands.
        self.assertRunOk("unbound-control stats")
        self.assertRunOk("unbound-control list_local_zones")

        # We check we see our test IPv4 address record.
        cmd = "nslookup -type=A somehost.buildroot.test."
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertIn("Address: 10.20.30.40", out)

        # We also check we see our reverse record.
        cmd = "nslookup 10.20.30.40"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected = "40.30.20.10.in-addr.arpa\tname = somehost.buildroot.test"
        self.assertIn(expected, out)

        # We check we see our test text record.
        cmd = "nslookup -type=TXT sometext.buildroot.test."
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected = "sometext.buildroot.test\ttext = \"Hello Buildroot TXT\""
        self.assertIn(expected, out)

        # We add a new record with unbound-control.
        record_data = "someotherhost.buildroot.test. IN A 10.99.99.99"
        cmd = f"unbound-control local_data \"{record_data}\""
        self.assertRunOk(cmd)

        # We check we see our new IPv4 address record.
        cmd = "nslookup -type=A someotherhost.buildroot.test."
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertIn("Address: 10.99.99.99", out)
