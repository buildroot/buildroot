import os
import time

import infra.basetest


class TestLibGpiod2(infra.basetest.BRTest):
    # This test needs a Kernel with the GPIO simulator module.
    kern_frag = \
        infra.filepath("tests/package/test_libgpiod2/linux-gpio-sim.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.40"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_PACKAGE_LIBGPIOD2=y
        BR2_PACKAGE_LIBGPIOD2_TOOLS=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="120M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def login(self):
        img = os.path.join(self.builddir, "images", "rootfs.ext2")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(
            arch="aarch64",
            kernel=kern,
            kernel_cmdline=[
                "root=/dev/vda",
                "console=ttyAMA0"],
            options=[
                "-M", "virt",
                "-cpu", "cortex-a57",
                "-m", "512",
                "-drive", f"file={img},if=virtio,format=raw"
            ]
        )
        self.emulator.login()

    def setup_gpio_sim(self):
        cfgfsdir = "/sys/kernel/config"
        gpiodir = f"{cfgfsdir}/gpio-sim"
        devname = "br-gpio"
        devdir = f"{gpiodir}/{devname}"
        banks = 2
        lines = 2

        # We need configfs mounted to use the gpio-sim module
        self.assertRunOk(f"mount -t configfs none {cfgfsdir}")

        # We setup a gpio device, with few banks and lines
        self.assertRunOk(f"mkdir {devdir}")
        for bank in range(banks):
            bankdir = f"{devdir}/bank{bank}"
            self.assertRunOk(f"mkdir {bankdir}")
            for line in range(lines):
                linedir = f"{devdir}/bank{bank}/line{line}"
                cmd = f"mkdir {linedir}"
                self.assertRunOk(cmd)

                # Set a name to the line
                name = f"br-b{bank}-l{line}"
                cmd = f"echo {name} > {linedir}/name"
                self.assertRunOk(cmd)

            # We set the total number of lines
            cmd = f"echo {lines} > {bankdir}/num_lines"
            self.assertRunOk(cmd)

        # Now our test device is configured, we can enable it.
        self.assertRunOk(f"echo 1 > {devdir}/live")

    def run_input_gpio_test(self):
        # We get the gpio input value. We expect an inactive state.
        gpioget_cmd = "gpioget --numeric br-b0-l0"
        out, ret = self.emulator.run(gpioget_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(int(out[0]), 0)

        # We pull up the line.
        cmd = "echo pull-up > /sys/devices/platform/gpio-sim.0/gpiochip0/sim_gpio0/pull"
        self.assertRunOk(cmd)

        # We query again the gpio. We now expect an active state.
        out, ret = self.emulator.run(gpioget_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(int(out[0]), 1)

    def run_output_gpio_test(self):
        # We query the output state, we expect an inactive state.
        get_gpio1_cmd = "cat /sys/devices/platform/gpio-sim.0/gpiochip0/sim_gpio1/value"
        out, ret = self.emulator.run(get_gpio1_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(int(out[0]), 0)

        # We run gpioset in background, so we are sure the gpio state
        # is held to the desired state.
        self.assertRunOk("gpioset br-b0-l1=1 &")
        time.sleep(2)

        # We query the output state again, we now expect an active state.
        out, ret = self.emulator.run(get_gpio1_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(int(out[0]), 1)

    def test_run(self):
        self.login()

        # We check a binary can execute.
        self.assertRunOk("gpiodetect --version")

        self.setup_gpio_sim()

        # We show the basic info reported by tools.
        self.assertRunOk("gpiodetect")
        self.assertRunOk("gpioinfo")

        self.run_input_gpio_test()
        self.run_output_gpio_test()
