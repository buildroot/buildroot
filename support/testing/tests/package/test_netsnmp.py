import os

import infra.basetest


class TestNetSNMP(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_netsnmp/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_NETSNMP=y
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

        # We check the daemon and a client program can execute.
        self.assertRunOk("snmpd --version")
        self.assertRunOk("snmpget --version")

        # The daemon is supposed to be started by the initscript,
        # since we included a /etc/snmp/snmpd.conf file. We should be
        # able to walk through the SNMPv2 system MIB.
        self.assertRunOk("snmpwalk -v 2c -c public 127.0.0.1 system")

        # We check few OIDs has the expected values. sysContact and
        # sysLocation are set in the snmpd.conf file.
        tests = [
            ("system.sysName.0", "STRING: buildroot"),
            ("system.sysContact.0", "STRING: Buildroot Test User"),
            ("system.sysLocation.0", "STRING: Buildroot Test Infra")
        ]
        for oid, expected_out in tests:
            cmd = f"snmpget -v 2c -c public -Ov 127.0.0.1 {oid}"
            out, ret = self.emulator.run(cmd)
            self.assertEqual(ret, 0)
            self.assertEqual(out[0], expected_out)
