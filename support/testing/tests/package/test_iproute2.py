import os

import infra.basetest


class TestIpRoute2(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_IPROUTE2=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute. This also check we are
        # actually using the version from the iproute2 package, rather
        # than the BusyBox version (which does not understand this
        # option).
        self.assertRunOk("ip -Version")

        # We run simple invocations of iproute2 tools.
        self.assertRunOk("ifstat")
        self.assertRunOk("ip link show dev lo")

        # Buildroot is supposed to have setup the loopback "lo"
        # interface. We should be able to ping any address in
        # the 127.0.0.0/8 subnet.
        addrs = ["127.0.0.1", "127.0.1.2", "127.1.2.3"]
        ping_cmd = "ping -c 3 -i 0.2"
        for addr in addrs:
            self.assertRunOk(f"{ping_cmd} {addr}")

        # We now change this 127.0.0.1/8 to a /16.
        self.assertRunOk("ip addr del 127.0.0.1/8 dev lo")
        self.assertRunOk("ip addr add 127.0.0.1/16 dev lo")

        # The IPs in the 127.0.0.0/16 subnet are still supposed to
        # ping...
        addrs = ["127.0.0.1", "127.0.1.2"]
        for addr in addrs:
            self.assertRunOk(f"{ping_cmd} {addr}")
        # ...but the IP outside is supposed to fail.
        _, ret = self.emulator.run(f"{ping_cmd} 127.1.2.3")
        self.assertNotEqual(ret, 0)

        # We add a prohibited route.
        self.assertRunOk("ip route add prohibit 127.0.1.0/24")

        # Now, only 127.0.0.1 is supposed to ping...
        self.assertRunOk(f"{ping_cmd} 127.0.0.1")
        # ...while the other IPs expected to fail.
        addrs = ["127.0.1.2", "127.1.2.3"]
        for addr in addrs:
            _, ret = self.emulator.run(f"{ping_cmd} {addr}")
            self.assertNotEqual(ret, 0)

        # We should be able to see our prohibited route.
        out, ret = self.emulator.run("ip route list")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0].strip(), "prohibit 127.0.1.0/24")

        # We create a new network namespace, and create a new shell
        # process in it.
        self.assertRunOk("ip netns add br-test")
        self.assertRunOk("ip netns exec br-test /bin/sh")

        # Since we are in a new namespace, we should no longer see the
        # prohibited route. The route list output should be empty.
        out, ret = self.emulator.run("ip route list")
        self.assertEqual(ret, 0)
        self.assertEqual(len(out), 0)
