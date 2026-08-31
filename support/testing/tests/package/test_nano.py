import os

import infra.basetest


class TestNano(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + """
    BR2_TARGET_ROOTFS_CPIO=y
    BR2_PACKAGE_NANO=y
    """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        cmd = "nano -V | grep 'GNU nano'"
        self.assertRunOk(cmd)

        self.emulator.qemu.sendline("nano")

        # send file contents
        self.emulator.qemu.send("test")
        # ^X for exit
        self.emulator.qemu.send(chr(0x18))
        # y for 'Save modified buffer?'
        self.emulator.qemu.send("y")
        # target filename
        self.emulator.qemu.send("file")
        # ^M for enter
        self.emulator.qemu.send(chr(0xd))

        self.emulator.qemu.sendline("clear; reset")

        # wait for prompt
        self.emulator.qemu.expect("# ")

        cmd = "cat file | grep '^test$'"
        self.assertRunOk(cmd)
