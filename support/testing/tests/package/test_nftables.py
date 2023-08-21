import os

import infra.basetest


class TestNftables(infra.basetest.BRTest):
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.46"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_NFTABLES=y
        BR2_PACKAGE_PYTHON3=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
                infra.filepath("tests/package/test_nftables/rootfs-overlay"))

    def nftables_test(self, prog="nft"):
        # Table/Chain names for the test
        nft_table = "br_ip_table"
        nft_chain = "br_ip_chain_in"

        # We flush all nftables rules, to start from a known state.
        self.assertRunOk(f"{prog} flush ruleset")

        # We create an ip table.
        self.assertRunOk(f"{prog} add table ip {nft_table}")

        # We should be able to list this table.
        list_cmd = f"{prog} list tables ip"
        output, exit_code = self.emulator.run(list_cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn(nft_table, output[0])

        # We create an ip input chain in our table.
        cmd = f"{prog} add chain ip"
        cmd += f" {nft_table} {nft_chain}"
        cmd += " { type filter hook input priority 0 \\; }"
        self.assertRunOk(cmd)

        # We list our chain.
        cmd = f"{prog} list chain ip {nft_table} {nft_chain}"
        self.assertRunOk(cmd)

        # We add a filter rule to drop pings (icmp echo-requests) to
        # the 127.0.0.2 destination.
        cmd = f"{prog} add rule ip {nft_table} {nft_chain}"
        cmd += " ip daddr 127.0.0.2 icmp type echo-request drop"
        self.assertRunOk(cmd)

        # We list our rule.
        self.assertRunOk(f"{prog} list ruleset ip")

        # A ping to 127.0.0.1 is expected to work, because it's not
        # matching our rule. We expect 3 replies (-c), with 0.5s
        # internal (-i), and set a maximum timeout of 2s.
        ping_cmd_prefix = "ping -c 3 -i 0.5 -W 2 "
        self.assertRunOk(ping_cmd_prefix + "127.0.0.1")

        # A ping to 127.0.0.2 is expected to fail, because our rule is
        # supposed to drop it.
        ping_test_cmd = ping_cmd_prefix + "127.0.0.2"
        _, exit_code = self.emulator.run(ping_test_cmd)
        self.assertNotEqual(exit_code, 0)

        # We completely delete the table. This should also delete the
        # chain and the rule.
        self.assertRunOk(f"{prog} delete table ip {nft_table}")

        # We should no longer see the table in the list.
        output, exit_code = self.emulator.run(list_cmd)
        self.assertEqual(exit_code, 0)
        self.assertNotIn(nft_table, "\n".join(output))

        # Since we deleted the rule, the ping test command which was
        # supposed to fail earlier is now supposed to succeed.
        self.assertRunOk(ping_test_cmd)

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-m", "256M",
                                    "-initrd", img])
        self.emulator.login()

        # We check the program can execute.
        self.assertRunOk("nft --version")

        # We run the nftables test sequence using the default "nft"
        # user space configuration tool.
        self.nftables_test()

        # We run again the same test sequence using our simple nft
        # python implementation, to check the language bindings.
        self.nftables_test(prog="/root/nft.py")
