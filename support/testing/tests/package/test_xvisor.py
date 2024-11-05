import os
import re

import infra.basetest


class TestXvisor(infra.basetest.BRTest):
    # RISC-V 64bit is the "simplest" configuration to run
    # Xvisor into QEmu.
    config = \
        """
        BR2_riscv=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_PACKAGE_XVISOR=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_OPENSBI=y
        BR2_TARGET_OPENSBI_CUSTOM_VERSION=y
        BR2_TARGET_OPENSBI_CUSTOM_VERSION_VALUE="1.5"
        BR2_TARGET_OPENSBI_PLAT="generic"
        BR2_PACKAGE_HOST_QEMU=y
        BR2_PACKAGE_HOST_QEMU_SYSTEM_MODE=y
        """
    xvisor_prompt = "XVisor# "

    def expect_xvisor_prompt(self, timeout=-1):
        self.emulator.qemu.expect(self.xvisor_prompt, timeout=timeout)

    def run_xvisor_cmd(self, cmd, timeout=-1):
        exit_code = 0
        if timeout != -1:
            timeout *= self.emulator.timeout_multiplier
        self.emulator.qemu.sendline(cmd)
        self.expect_xvisor_prompt(timeout)
        output = self.emulator.qemu.before.replace("\r\r", "\r").splitlines()[1:]
        # Some Xvisor commands (like "sleep") might not
        # produce any output
        if len(output) > 0:
            last_line = output[-1]
        else:
            last_line = ""
        if last_line.startswith("Error:"):
            match = re.search(last_line, r"code (-?\d)")
            if match is None:
                exit_code = -1
            else:
                exit_code = int(match.group(1))

        return output, exit_code

    def assertXvRunOk(self, cmd, timeout=-1):
        out, exit_code = self.run_xvisor_cmd(cmd, timeout)
        self.assertEqual(
            exit_code,
            0,
            "\nFailed to run xvisor command: {}\noutput was:\n{}".format(
                cmd, '  '+'\n  '.join(out))
        )

    def test_run(self):
        opensbi = os.path.join(self.builddir, "images", "fw_jump.bin")
        xvisor = os.path.join(self.builddir, "images", "vmm.bin")
        initrd = os.path.join(self.builddir, "images", "rootfs.cpio")

        self.emulator.boot(arch="riscv64",
                           kernel=xvisor,
                           options=["-M", "virt", "-cpu", "rv64", "-m", "256M",
                                    "-bios", opensbi, "-initrd", initrd])

        # There is no emulator.login(), since we start directly in
        # Xvisor prompt.
        self.expect_xvisor_prompt()

        # Check Xvisor version.
        output, exit_code = self.run_xvisor_cmd("version")
        self.assertEqual(exit_code, 0)
        self.assertTrue(output[0].startswith("Xvisor"))

        # Check a basic echo.
        test_str = "Hello Buildroot!"
        output, exit_code = self.run_xvisor_cmd("echo " + test_str)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0].strip(), test_str)

        # Check a nonexisting command fails.
        _, exit_code = self.run_xvisor_cmd("bad_command")
        self.assertNotEqual(exit_code, 0)

        # Check an error of a valid command.
        _, exit_code = self.run_xvisor_cmd("vfs ls /nodir")
        self.assertNotEqual(exit_code, 0)

        # We mount the initrd...
        self.assertXvRunOk("vfs mount initrd /")

        # Check we see an existing file/symlink "os-release" in
        # "/etc", from our mounted initrd.
        output, exit_code = self.run_xvisor_cmd("vfs ls /etc")
        self.assertEqual(exit_code, 0)
        self.assertIn("os-release", "\n".join(output))

        # Check the word "Buildroot" is in the /etc/issue file.
        output, exit_code = self.run_xvisor_cmd("vfs cat /etc/issue")
        self.assertEqual(exit_code, 0)
        self.assertIn("Buildroot", "\n".join(output))

        # Check qemu is seen in host info.
        output, exit_code = self.run_xvisor_cmd("host info")
        self.assertEqual(exit_code, 0)
        self.assertIn("qemu", "\n".join(output))

        # Run a batch of status commands...
        cmds = [
            "blockdev list",
            "rbd list",
            "module info 0",
            "wallclock get_time",
            "heap info",
            "thread list",
            "vcpu list",
            "vcpu dumpreg 0",
            "devtree node show /",
            "host cpu info",
            "host ram info",
            "host resources",
            "host bus_list",
            "host bus_device_list platform"
        ]

        for cmd in cmds:
            self.assertXvRunOk(cmd)
