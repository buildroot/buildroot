import os

import infra.basetest


class TestKmod(infra.basetest.BRTest):
    # This test uses the "virtio_net" driver compiled as a module. We
    # need to recompile a Kernel for that.
    kernel_fragment = \
        infra.filepath("tests/package/test_kmod/linux-virtio-net.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.35"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kernel_fragment}"
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_KMOD=y
        BR2_PACKAGE_KMOD_TOOLS=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda console=ttyAMA0"],
                           options=["-M", "virt",
                                    "-cpu", "cortex-a57",
                                    "-m", "256M",
                                    "-drive", f"file={drive},if=virtio,format=raw"])
        self.emulator.login()

        # We check the kmod program can run. Busybox does not have a
        # kmod applet, so there is no possible confusion.
        self.assertRunOk("kmod --version")

        # We check the "modprobe" is the one from kmod, rather than
        # the Busybox applet version.
        out, ret = self.emulator.run("modprobe --version")
        self.assertEqual(ret, 0)
        self.assertTrue(out[0].startswith("kmod version"))

        # List modules with "kmod list", the virtio-net module should
        # NOT be loaded yet.
        out, ret = self.emulator.run("kmod list")
        self.assertEqual(ret, 0)
        self.assertNotIn("virtio_net", "\n".join(out))

        # Get module info with modinfo.
        out, ret = self.emulator.run("modinfo virtio-net")
        self.assertEqual(ret, 0)
        lsmod_out = "\n".join(out)
        self.assertRegex(lsmod_out, r'name: *virtio_net')
        self.assertRegex(lsmod_out, r'description: *Virtio network driver')

        # With this test configuration, we are not supposed to have an
        # eth0 Ethernet interface yet. Attempting to show info on this
        # interface is expected to fail .
        _, ret = self.emulator.run("ip link show dev eth0")
        self.assertNotEqual(ret, 0)

        # We try to load the module.
        self.assertRunOk("modprobe virtio-net")

        # We should now see the module in the list. This time, we use
        # the "lsmod" command.
        out, ret = self.emulator.run("lsmod")
        self.assertEqual(ret, 0)
        self.assertIn("virtio_net", "\n".join(out))

        # The eth0 interface is supposed to be available, after the
        # module loading. We configure the emulator user network to
        # test the driver networking functionality. See:
        # https://wiki.qemu.org/Documentation/Networking
        self.assertRunOk("ip addr add dev eth0 10.0.2.15/24")
        self.assertRunOk("ip link set dev eth0 up")

        # We check we can ping the emulator.
        ping_cmd = "ping -i 0.3 -c 2 10.0.2.2"
        self.assertRunOk(ping_cmd)

        # We check we can unload the driver.
        self.assertRunOk("modprobe -r virtio-net")

        # Now the driver is unloaded, we should no longer be able to
        # ping the emulator.
        _, ret = self.emulator.run(ping_cmd)
        self.assertNotEqual(ret, 0)
