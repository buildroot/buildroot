import os

import infra.basetest


class TestSquashfs(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_SQUASHFS=y
        BR2_TARGET_ROOTFS_SQUASHFS4_LZO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        unsquashfs_cmd = ["host/bin/unsquashfs", "-s", "images/rootfs.squashfs"]
        out = infra.run_cmd_on_host(self.builddir, unsquashfs_cmd)
        out = out.splitlines()
        self.assertEqual(out[0],
                         "Found a valid SQUASHFS 4:0 superblock on images/rootfs.squashfs.")
        self.assertEqual(out[3], "Compression lzo")

        img = os.path.join(self.builddir, "images", "rootfs.squashfs")
        infra.img_round_power2(img)

        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           kernel_cmdline=["root=/dev/mmcblk0",
                                           "rootfstype=squashfs"],
                           options=["-drive", "file={},if=sd,format=raw".format(img)])
        self.emulator.login()

        cmd = "mount | grep '/dev/root on / type squashfs'"
        self.assertRunOk(cmd)
