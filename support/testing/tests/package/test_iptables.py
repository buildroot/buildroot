import os

import infra.basetest


class TestIptables(infra.basetest.BRTest):
    # The iptables package has _LINUX_CONFIG_FIXUPS, so we cannot use
    # the runtime test pre-built Kernel. We need to compile a Kernel
    # to make sure it will include the required configuration.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_INIT_BUSYBOX=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.82"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_IPTABLES=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

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
        self.assertRunOk("iptables --version")

        # We delete all rules in all chains. We also set default
        # policies to ACCEPT for INPUT and OUTPUT chains. This should
        # already be the case (default Kernel config). This makes sure
        # this test starts from a known state and also those common
        # command invocations works.
        self.assertRunOk("iptables --flush")
        self.assertRunOk("iptables --policy INPUT ACCEPT")
        self.assertRunOk("iptables --policy OUTPUT ACCEPT")

        # We add a filter rule to drop all the ICMP protocol to the
        # IPv4 destination 127.0.0.2, in the INPUT chain. This should
        # block all pings (icmp echo-requests).
        cmd = "iptables --append INPUT"
        cmd += " --protocol icmp --destination 127.0.0.2 --jump DROP"
        self.assertRunOk(cmd)

        # We check we can list rules.
        self.assertRunOk("iptables --list")

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

        # Save the current rules to test the init script later.
        self.assertRunOk("/etc/init.d/S35iptables save")

        # We delete our only rule #1 in the INPUT chain.
        self.assertRunOk("iptables --delete INPUT 1")

        # Since we deleted the rule, the ping test command which was
        # supposed to fail earlier is now supposed to succeed.
        self.assertRunOk(ping_test_cmd)

        # Load the rules as saved before.
        self.assertRunOk("/etc/init.d/S35iptables start")

        # Ping to 127.0.0.2 is expected to fail again.
        _, exit_code = self.emulator.run(ping_test_cmd)
        self.assertNotEqual(exit_code, 0)

        # And flush the rules again.
        self.assertRunOk("/etc/init.d/S35iptables stop")

        # Since we deleted the rule, the ping test command which was
        # supposed to fail earlier is now supposed to succeed.
        self.assertRunOk(ping_test_cmd)
