import os

import infra.basetest


class TestMdnsd(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_MDNSD=y
        BR2_PACKAGE_MDNSD_MQUERY=y
        BR2_PACKAGE_MDNSD_HTTP_SERVICE=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", img,
                                    "-net", "nic,model=rtl8139",
                                    "-net", "user"])
        self.emulator.login()

        # We check the program can execute.
        self.assertRunOk("mdnsd -v")

        # The responder is started at boot by /etc/init.d/S50mdnsd and
        # advertises the bundled _http._tcp service from /etc/mdns.d/.
        self.assertRunOk("pidof mdnsd")

        # mdnsd only answers on multicast capable interfaces that are
        # up, so wait for eth0 to get its DHCP address before querying.
        cmd = "while ! ifconfig eth0 | grep -q 'inet addr'; do sleep 1; done"
        self.assertRunOk(cmd, timeout=30)

        # mquery sends a multicast query for the advertised service;
        # output is one "+ NAME (IP)" line per instance
        cmd = "mquery -T _http._tcp |grep -F buildroot._http._tcp.local"
        self.assertRunOk(cmd, timeout=30)
