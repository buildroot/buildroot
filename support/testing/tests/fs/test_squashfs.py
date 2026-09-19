import os
import re

import infra.basetest


class TestSquashfs(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_SQUASHFS=y
        BR2_TARGET_ROOTFS_SQUASHFS4_LZO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    expected_blocksize_in_bytes = 128*1024

    def test_run(self):
        unsquashfs_cmd = ["host/bin/unsquashfs", "-s", "images/rootfs.squashfs"]
        out = infra.run_cmd_on_host(self.builddir, unsquashfs_cmd)
        out = out.splitlines()
        self.assertEqual(out[0],
                         "Found a valid SQUASHFS 4:0 superblock on images/rootfs.squashfs.")
        self.assertEqual(out[3], "Compression lzo")
        self.assertEqual(out[4], "Block size {}".format(self.expected_blocksize_in_bytes))

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


class TestSquashfsMinBlocksize(TestSquashfs):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_SQUASHFS=y
        BR2_TARGET_ROOTFS_SQUASHFS_BS_4K=y
        BR2_TARGET_ROOTFS_SQUASHFS4_LZO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    expected_blocksize_in_bytes = 4*1024


class TestSquashfsMaxBlocksize(TestSquashfs):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_SQUASHFS=y
        BR2_TARGET_ROOTFS_SQUASHFS_BS_1024K=y
        BR2_TARGET_ROOTFS_SQUASHFS4_LZO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    expected_blocksize_in_bytes = 1024*1024


class TestSquashfsVerity(infra.basetest.BRTest):
    kernel_fragment = \
        infra.filepath("tests/fs/test_squashfs/linux-verity.fragment")
    genimage_config = \
        infra.filepath("tests/fs/test_squashfs/genimage-verity.cfg")
    hash_algo = "sha384"
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.52"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kernel_fragment}"
        BR2_TARGET_ROOTFS_SQUASHFS=y
        BR2_TARGET_ROOTFS_SQUASHFS4_LZO=y
        BR2_TARGET_ROOTFS_SQUASHFS_VERITY=y
        BR2_TARGET_ROOTFS_SQUASHFS_VERITY_EXTRA_ARGS="--hash {hash_algo}"
        BR2_ROOTFS_POST_IMAGE_SCRIPT="support/scripts/genimage.sh"
        BR2_ROOTFS_POST_SCRIPT_ARGS="-c {genimage_config}"
        BR2_PACKAGE_CRYPTSETUP=y
        BR2_PACKAGE_HOST_GENIMAGE=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self) -> None:
        img = os.path.join(self.builddir, "images", "rootfs.squashfs")
        hash_img = f"{img}.verity"
        root_hash_file = f"{hash_img}.root-hash"
        verify_cmd = [
            "host/sbin/veritysetup", "verify",
            "--root-hash-file", root_hash_file, img, hash_img
        ]
        infra.run_cmd_on_host(self.builddir, verify_cmd)

        dump_cmd = ["host/sbin/veritysetup", "dump", hash_img]
        out = infra.run_cmd_on_host(self.builddir, dump_cmd)
        params = dict()
        for line in out.splitlines():
            m = re.match(r"^(.*):\s+(\S+)", line)
            if m is None:
                continue
            params[m.group(1)] = m.group(2)

        data_block_size = int(params["Data block size"])
        data_blocks = int(params["Data blocks"])
        sector_size = 512  # default
        data_sectors = data_blocks * data_block_size // sector_size
        hash_algorithm = params["Hash algorithm"]
        hash_start_block = 1  # skip header
        hash_block_size = int(params["Hash block size"])
        salt = params["Salt"]
        with open(root_hash_file) as fh:
            root_hash = fh.read()

        # check if setting --hash in
        # BR2_TARGET_ROOTFS_SQUASHFS_VERITY_EXTRA_ARGS worked
        self.assertEqual(hash_algorithm, self.hash_algo)

        disk_img = os.path.join(self.builddir, "images", "disk.img")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(
            arch="aarch64",
            kernel=kern,
            kernel_cmdline=[
                "console=ttyAMA0",
                "root=/dev/dm-0",
                "rootfstype=squashfs",
                f'dm-mod.create="verity,,,ro,0 {data_sectors} verity 1 '
                f'/dev/vda1 /dev/vda2 {data_block_size} {hash_block_size} '
                f'{data_blocks} {hash_start_block} {hash_algorithm} '
                f'{root_hash} {salt}"',
            ],
            options=[
                "-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                "-drive", f"file={disk_img},if=virtio,format=raw",
            ])
        self.emulator.login()

        self.assertRunOk("mount | grep '/dev/root on / type squashfs'")
        out, ret = self.emulator.run("dmsetup info verity", 5)
        self.assertEqual(ret, 0)
        state = next(filter(lambda s: s.startswith("State:"), out))
        self.assertRegex(state, r"^State:\s+ACTIVE \(READ-ONLY\)$")
