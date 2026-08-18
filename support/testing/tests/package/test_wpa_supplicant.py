import os
import time

import infra.basetest


class TestWPASupplicant(infra.basetest.BRTest):
    test_dir = "tests/package/test_wpa_supplicant"
    # This test uses the mac80211_hwsim kernel test driver. See:
    # https://docs.kernel.org/networking/mac80211_hwsim/mac80211_hwsim.html
    kern_frag = \
        infra.filepath(f"{test_dir}/linux-mac80211-hwsim.fragment")
    rootfs_overlay = \
        infra.filepath(f"{test_dir}/rootfs-overlay")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.44"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_HOSTAPD=y
        BR2_PACKAGE_IPROUTE2=y
        BR2_PACKAGE_IW=y
        BR2_PACKAGE_WPA_SUPPLICANT=y
        BR2_PACKAGE_WPA_SUPPLICANT_CLI=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        disk = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        bootargs = ["root=/dev/vda"]
        qemu_opts = ["-M", "virt", "-cpu", "cortex-a57", "-m", "512M",
                     "-drive", f"file={disk},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # We check the program can run.
        self.assertRunOk("wpa_supplicant -v")

        # We define a network namespace to isolate our
        # access point components.
        ns = "ap-ns"

        # We create the network namespace.
        self.assertRunOk(f"ip netns add {ns}")

        # We isolate our wireless network device in our namespace.
        self.assertRunOk(f"iw phy phy0 set netns name {ns}")

        # We define the command prefix to execute commands inside
        # our network namespace.
        ns_exec = f"ip netns exec {ns}"

        # We start the hostapd daemon.
        cmd = [
            ns_exec,
            "hostapd",
            "-B",
            "-f /var/log/hostapd.log",
            "/etc/hostapd.conf"
        ]
        self.assertRunOk(" ".join(cmd))

        # We wait for the wlan0 interface to come up.
        for attempt in range(10):
            time.sleep(3)

            cmd = ns_exec
            cmd += " cat /sys/class/net/wlan0/operstate"
            out, ret = self.emulator.run(cmd)
            self.assertEqual(ret, 0)
            if out[0] == "up":
                break
        else:
            self.fail("Timeout while waiting for wlan0 to be up.")

        # We start the wpa_supplicant client process.
        cmd = [
            "wpa_supplicant",
            "-B",
            "-f /var/log/wpa_supplicant.log",
            "-i wlan1",
            "-c /etc/wpa_supplicant.conf"
        ]
        self.assertRunOk(" ".join(cmd))

        # We wait for the wlan1 interface to come up.
        for attempt in range(10):
            time.sleep(3)

            cmd = "cat /sys/class/net/wlan1/operstate"
            out, ret = self.emulator.run(cmd)
            self.assertEqual(ret, 0)
            if out[0] == "up":
                break
        else:
            self.fail("Timeout while waiting for wlan1 to be up.")

        # We set an IP address on the wlan0 hostapd side.
        cmd = ns_exec
        cmd += " ip addr add dev wlan0 192.168.1.111/24"
        self.assertRunOk(cmd)

        # We set an IP address on the wlan1 wpa_supplicant side.
        self.assertRunOk("ip addr add dev wlan1 192.168.1.222/24")

        # We check we can ping the hostapd wlan0 IP address.
        self.assertRunOk("ping -c 3 -i 0.2 -W 2 192.168.1.111")
