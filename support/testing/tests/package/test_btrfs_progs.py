import os
import subprocess

import infra.basetest


class TestBtrfsProgs(infra.basetest.BRTest):
    # This test needs a Kernel with btrfs support.
    kern_frag = \
        infra.filepath("tests/package/test_btrfs_progs/linux-btrfs.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.39"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_BTRFS_PROGS=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        # Prepare the disk image.
        disk_file = os.path.join(self.builddir, "images", "disk.img")
        self.emulator.logfile.write(f"Creating disk image: {disk_file}")
        self.emulator.logfile.flush()
        subprocess.check_call(
            ["dd", "if=/dev/zero", f"of={disk_file}", "bs=1M", "count=256"],
            stdout=self.emulator.logfile,
            stderr=self.emulator.logfile)

        # Run the emulator with a blank drive.
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        bootargs = ["console=ttyAMA0"]
        qemu_opts = ["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                     "-initrd", img,
                     "-drive", f"file={disk_file},if=virtio,format=raw"]
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=bootargs,
                           options=qemu_opts)
        self.emulator.login()

        # Check a program can run and show its version.
        self.assertRunOk("btrfs --version")

        # Variables for this test.
        dev = "/dev/vda"
        label = "BR_TEST"
        mnt_pt = "/tmp/btrfs"
        data_file = f"{mnt_pt}/data.bin"
        txt = "Hello Buildroot!"
        subvol = f"{mnt_pt}/my-subvolume"
        snapshot = f"{mnt_pt}/my-snapshot"

        # We create the btrfs filesystem on our device.
        self.assertRunOk(f"mkfs.btrfs {dev}", timeout=10)

        # We set a label on this filesystem.
        self.assertRunOk(f"btrfs filesystem label {dev} '{label}'")

        # We create a mount point and mount this filesystem.
        self.assertRunOk(f"mkdir -p {mnt_pt}")
        self.assertRunOk(f"mount {dev} {mnt_pt}")

        # We create a file with random data, to use this new
        # filesystem a bit.
        self.assertRunOk(f"dd if=/dev/urandom of={data_file} bs=1M count=10")

        # We compute the sha256 hash and save it for later.
        hash_cmd = f"sha256sum {data_file}"
        out, ret = self.emulator.run(hash_cmd)
        self.assertEqual(ret, 0)
        data_sha256 = out[0]

        # We unmount the filesystem.
        self.assertRunOk(f"umount {mnt_pt}")

        # We run a filesystem check (this tool is the equivalent of
        # "fsck"). Since we cleanly unmounted the filesystem,
        # we are not expecting any repair. This is just to test the
        # program works correctly.
        self.assertRunOk(f"btrfs check {dev}")

        # We query the label and check it is the one we set at the
        # beginning.
        out, ret = self.emulator.run(f"btrfs filesystem label {dev}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], label)

        # We remount our filesystem.
        self.assertRunOk(f"mount {dev} {mnt_pt}")

        # We perform a scrub in foreground.
        self.assertRunOk(f"btrfs scrub start -B {mnt_pt}")

        # We show device usage and statistics.
        self.assertRunOk(f"btrfs device usage {mnt_pt}")
        self.assertRunOk(f"btrfs device stats {mnt_pt}")

        # We create a btrfs subvolume and create a file in it.
        self.assertRunOk(f"btrfs subvolume create {subvol}")
        self.assertRunOk(f"echo '{txt}' > {subvol}/file.txt")

        # We create a read-only snapshot of this subvolume and we
        # delete our file previously created.
        self.assertRunOk(f"btrfs subvolume snapshot -r {subvol} {snapshot}")
        self.assertRunOk(f"rm -f {subvol}/file.txt")

        # We should still see our file in our snapshot.
        out, ret = self.emulator.run(f"cat {snapshot}/file.txt")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], txt)

        # We should recompute the same sha256 hash as before, on the
        # first data file we created at the beginning.
        out, ret = self.emulator.run(hash_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], data_sha256)
