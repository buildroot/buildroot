import os
import subprocess

import infra.basetest


class TestParted(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_E2FSPROGS=y
        BR2_PACKAGE_PARTED=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        # Prepare the disk image.
        disk_file = os.path.join(self.builddir, "images", "disk.img")
        self.emulator.logfile.write(f"Creating disk image: {disk_file}\n")
        self.emulator.logfile.flush()
        subprocess.check_call(
            ["dd", "if=/dev/zero", f"of={disk_file}", "bs=1M", "count=256"],
            stdout=self.emulator.logfile,
            stderr=self.emulator.logfile)

        # Run the emulator with a drive.
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=[
                                "-initrd", cpio_file,
                                "-drive", f"file={disk_file},format=raw"])
        self.emulator.login()

        # We check the program can run.
        self.assertRunOk("parted --version")

        dev = "/dev/sda"
        parted = f"parted {dev}"

        # We print the partition list of our drive. Since the drive is
        # supposed to be blank, it should not have a partition table.
        part_list_cmd = f"{parted} print list"
        out, ret = self.emulator.run(part_list_cmd, timeout=10)
        self.assertEqual(ret, 0)
        self.assertIn("Partition Table: unknown", out)

        # We create a GPT partition table.
        mklabel_cmd = f"{parted} mklabel gpt"
        self.assertRunOk(mklabel_cmd, timeout=10)

        # We print again the partition list. We should now see our
        # partition table.
        out, ret = self.emulator.run(part_list_cmd, timeout=10)
        self.assertEqual(ret, 0)
        self.assertIn("Partition Table: gpt", out)

        # We create 3 partitions on our drive.
        partitions = [
            "MyPart1 ext2 1MiB 25%",
            "MyPart2 ext4 25% 50%",
            "MyPart3 ext4 50% 100%"
        ]
        for part in partitions:
            mkpart_cmd = f"{parted} mkpart {part}"
            self.assertRunOk(mkpart_cmd, timeout=10)

        # We print again the list of partitions, this time in machine
        # parseable format. We check we have our 3 partitions.
        cmd = f"parted -m {dev} print list"
        out, ret = self.emulator.run(cmd, timeout=10)
        self.assertEqual(ret, 0)
        for part in range(1, 4):
            self.assertTrue(out[1+part].startswith(f"{part}:"))
            self.assertTrue(out[1+part].endswith(f":MyPart{part}:;"))

        # We format our partitions.
        self.assertRunOk(f"mkfs.ext2 {dev}1", timeout=10)
        self.assertRunOk(f"mkfs.ext4 {dev}2", timeout=10)
        self.assertRunOk(f"mkfs.ext4 {dev}3", timeout=10)

        # We create a random data file in the temporary directory. It
        # will be the reference source file that will be copied later
        # on each of our filesystems.
        data_file = "data.bin"
        cmd = f"dd if=/dev/urandom of=/tmp/{data_file} bs=1M count=10"
        self.assertRunOk(cmd)

        # We compute the sha256 hash and save it for later.
        hash_cmd = f"sha256sum {data_file}"
        out, ret = self.emulator.run(f"( cd /tmp && {hash_cmd} )")
        self.assertEqual(ret, 0)
        data_sha256 = out[0]

        # For each partition, we create a mount point directory, mount
        # the filesystem, copy the reference data file in it, sync the
        # filesystem, and compute the sha256 hash of the file. This
        # sequence will exercise a bit the partitions and filesystems
        # in read/write operations.
        for part in range(1, 4):
            self.assertRunOk(f"mkdir -p /tmp/MyPart{part}")
            self.assertRunOk(f"mount {dev}{part} /tmp/MyPart{part}")
            self.assertRunOk(f"cp /tmp/{data_file} /tmp/MyPart{part}/")
            self.assertRunOk("sync")
            out, ret = self.emulator.run(f"( cd /tmp/MyPart{part} && {hash_cmd} )")
            self.assertEqual(ret, 0)
            self.assertEqual(out[0], data_sha256)
