import os
import time

import infra.basetest


class TestJailhouse(infra.basetest.BRTest):
    # This test uses a specific configuration, mainly for matching the
    # requirements of the Jailhouse Qemu inmate demo. We also use the
    # Linux kernel from Siemens, which includes patches for
    # Jailhouse. Finally, we use the kernel config from
    # board/qemu/aarch64-virt rather than the Kernel defconfig, for
    # faster build (as it enable less components, but includes
    # everything needed for this test).
    kernel_ver = "eb6927f7eea77f823b96c0c22ad9d4a2d7ffdfce"
    kernel_url = \
        f"$(call github,siemens,linux,{kernel_ver})/linux-{kernel_ver}.tar.gz"
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_TARBALL=y
        BR2_LINUX_KERNEL_CUSTOM_TARBALL_LOCATION="{kernel_url}"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_PACKAGE_JAILHOUSE=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "Image")
        # Qemu option and Kernel args are taken from Jailhouse demo. See:
        # https://github.com/siemens/jailhouse/blob/master/README.md
        # We also add oops=panic to improve the test coverage.
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda console=ttyAMA0 mem=768M oops=panic"],
                           options=["-M", "virt,gic-version=3,virtualization=on,its=off",
                                    "-cpu", "cortex-a57",
                                    "-m", "1G",
                                    "-smp", "16",
                                    "-drive", f"file={drive},if=none,format=raw,id=hd0",
                                    "-device", "virtio-blk-device,drive=hd0"])
        self.emulator.login()

        # Check the program can execute.
        self.assertRunOk("jailhouse --version")

        # Load the kernel module.
        self.assertRunOk("modprobe jailhouse")

        # Check the device is present.
        self.assertRunOk("ls -al /dev/jailhouse")

        # Load the cell config this this qemu test.
        self.assertRunOk("jailhouse enable /etc/jailhouse/qemu-arm64.cell")

        # Dump the jailhouse console, and check we see its
        # initialization string.
        out, ret = self.emulator.run("jailhouse console")
        self.assertEqual(ret, 0)
        self.assertIn("Initializing Jailhouse hypervisor", "\n".join(out))

        # Create the cell.
        cell_cfg = "/etc/jailhouse/qemu-arm64-inmate-demo.cell"
        cmd = f"jailhouse cell create {cell_cfg}"
        self.assertRunOk(cmd)

        # Load the demo image.
        cell_name = "inmate-demo"
        img = "/usr/libexec/jailhouse/demos/gic-demo.bin"
        cmd = f"jailhouse cell load {cell_name} {img}"
        self.assertRunOk(cmd)

        # List Jailhouse cells and check we see the one we loaded.
        out, ret = self.emulator.run("jailhouse cell list")
        self.assertEqual(ret, 0)
        self.assertIn(cell_name, "\n".join(out))

        # We should also see our cell in sysfs.
        cmd = "cat /sys/devices/jailhouse/cells/1/name"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], cell_name)

        # Start the cell.
        self.assertRunOk(f"jailhouse cell start {cell_name}")

        # Let the demo cell run for few seconds...
        time.sleep(3)

        # Stop and unload the cell.
        self.assertRunOk(f"jailhouse cell shutdown {cell_name}")
        self.assertRunOk(f"jailhouse cell destroy {cell_name}")

        # Stop and unload jailhouse.
        self.assertRunOk("jailhouse disable")
        self.assertRunOk("modprobe -r jailhouse")
