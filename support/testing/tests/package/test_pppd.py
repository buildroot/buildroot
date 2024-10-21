import os
import time

import infra.basetest


class TestPppd(infra.basetest.BRTest):
    # This test needs a Kernel with ppp support.
    kern_frag = \
        infra.filepath("tests/package/test_pppd/linux-ppp.fragment")
    # Our test config also enables socat and iproute2 used as
    # supporting tools for this test.
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.57"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_IPROUTE2=y
        BR2_PACKAGE_PPPD=y
        BR2_PACKAGE_SOCAT=y
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
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M", "-initrd", img])
        self.emulator.login()

        # We define our socat output log file.
        socat_log = "/tmp/socat.log"

        # We define two PTY names we will use for this test.
        pty0 = "/dev/ttyppp0"
        pty1 = "/dev/ttyppp1"

        # We define two IP addresses.
        local_ip = "192.168.12.34"
        remote_ip = "10.20.30.40"

        # We define few parameters for our ping.
        ping_count = 3
        ping_size = 32
        ping_payload = "aa"

        # We check the program can execute.
        self.assertRunOk("pppd --version")

        # We create two PTYs connected to each other with socat. We
        # will connect a pppd on each one to create connection end
        # points. We also enable some debugging to print the content
        # of packets forwarded by socat. We will use that to later
        # validate data actually passed through this channel. Note: we
        # start the command in a subshell to suppress the job control
        # message, when this background process will be killed later
        # in this test.
        cmd = "( socat -d2 -x -lu"
        cmd += f" PTY,link={pty0},rawer,b115200 PTY,link={pty1},rawer,b115200"
        cmd += f" > {socat_log} 2>&1 & )"
        self.assertRunOk(cmd)

        # We create a network namespace. We will use it to isolate one
        # of the two pppd instances (our fake remote). We do so to
        # make sure our network test will not use the default routes
        # (or local loopback). This will make sure our communication
        # data will go through our PPP link.
        namespace = "remote-ppp"
        self.assertRunOk(f"ip netns add {namespace}")

        # We start our (fake) remote pppd instance, in our netns.
        cmd = f"ip netns exec {namespace} "
        cmd += f"pppd noauth ifname ppp1 {pty1} {remote_ip}:{local_ip}"
        self.assertRunOk(cmd)

        # We wait a bit for the pppd to settle...
        time.sleep(3)

        # We start out local pppd instance, this time in the default
        # network namespace.
        cmd = f"pppd noauth ifname ppp0 {pty0} {local_ip}:{remote_ip}"
        self.assertRunOk(cmd)

        # We wait again...
        time.sleep(3)

        # We check we can ping our two IPs. The local IP is expected
        # to go through the interface loopback (and not go through our
        # PPP link). Only the remote IP ping is expected to go through
        # our socat PTYs.
        for ip in local_ip, remote_ip:
            cmd = f"ping -c {ping_count} -s {ping_size} -p {ping_payload} {ip}"
            self.assertRunOk(cmd)

        # We stop our pppd and socat processes.
        self.assertRunOk("killall pppd")
        self.assertRunOk("killall socat")

        # For debugging this test, it can be useful to print the socat
        # log on the console. Uncomment this line, if needed.
        # self.assertRunOk(f"cat {socat_log}")

        # The actual ping payload set with our payload_data is
        # slightly smaller as the ping packet size, due other data
        # written by the ping command. This is why we subtract 4 bytes
        # to the size.
        pattern = " ".join([ping_payload] * (ping_size - 4))
        # We count the number of packets with this payload transmitted
        # through socat...
        out, ret = self.emulator.run(f"grep -Fc '{pattern}' {socat_log}")
        self.assertEqual(ret, 0)
        # We check we have exactly twice our requested ping count (one
        # for ICMP ECHO, one for the REPLY).
        self.assertEqual(int(out[0]), ping_count * 2)
