import os

import infra.basetest


class TestIputils(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_IPUTILS=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check all the main programs of iputils can execute and
        # report their version. Note the "-V" option is not accepted
        # and fails if the "ping" applet of BusyBox is used instead.
        iputils_progs = ["arping", "clockdiff", "ping", "tracepath"]
        for prog in iputils_progs:
            self.assertRunOk(f"{prog} -V")

        # Qemu host IP, See:
        # https://wiki.qemu.org/Documentation/Networking#User_Networking_(SLIRP)
        qemu_host = "10.0.2.2"

        # We test the "arping" program, with 3 pings.
        self.assertRunOk(f"arping -c 3 {qemu_host}", timeout=10)

        # We test the "ping" program. We use the option "-D" which
        # shows a timestamp and is also not supported by the "ping"
        # BusyBox applet.
        self.assertRunOk(f"ping -D -c 3 {qemu_host}", timeout=10)

        # We test the "tracepath" program. We set the max hops to 2,
        # since there is no intermediate routers.
        self.assertRunOk(f"tracepath -m 2 {qemu_host}", timeout=10)

        # We test the "clockdiff" program. We cannot use the Qemu host
        # IP for this program as the ICMP TIMESTAMP is used and is not
        # responded. We use the local host instead.
        self.assertRunOk("clockdiff 127.0.0.1", timeout=10)
