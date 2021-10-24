import subprocess
import os

import infra.basetest


class TestUbi(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_UBIFS=y
        BR2_TARGET_ROOTFS_UBIFS_LEBSIZE=0x3ff80
        BR2_TARGET_ROOTFS_UBIFS_MINIOSIZE=0x1
        BR2_TARGET_ROOTFS_UBI=y
        BR2_TARGET_ROOTFS_UBI_PEBSIZE=0x40000
        BR2_TARGET_ROOTFS_UBI_SUBSIZE=1
        BR2_TARGET_ROOTFS_UBI_USE_CUSTOM_CONFIG=y
        BR2_TARGET_ROOTFS_UBI_CUSTOM_CONFIG_FILE="{}"
        """.format(
              infra.filepath("tests/fs/test_ubi/ubinize_qemu_pflash_cfi01.cfg"))

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.ubi")
        out = infra.run_cmd_on_host(self.builddir, ["file", img])
        out = out.splitlines()
        self.assertIn("UBI image, version 1", out[0])

        subprocess.call(["truncate", "-s 64M", img])

        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           kernel_cmdline=["root=ubi0:rootfs",
                                           "ubi.mtd=0",
                                           "rootfstype=ubifs"],
                           options=["-drive", "file={},if=pflash,format=raw".format(img)])
        self.emulator.login()
        cmd = "mount | grep 'ubi0:rootfs on / type ubifs'"
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
