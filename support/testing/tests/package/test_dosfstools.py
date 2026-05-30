import os
import subprocess

import infra.basetest


class TestDosFsTools(infra.basetest.BRTest):
    # This test needs a Kernel with vfat and NLS support. The vfat
    # filesystem also needs character set conversion libraries, since
    # its default encoding is CP850.
    kern_frag = \
        infra.filepath("tests/package/test_dosfstools/linux-vfat.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.6.47"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_DOSFSTOOLS=y
        BR2_PACKAGE_DOSFSTOOLS_FATLABEL=y
        BR2_PACKAGE_DOSFSTOOLS_FSCK_FAT=y
        BR2_PACKAGE_DOSFSTOOLS_MKFS_FAT=y
        BR2_SYSTEM_ENABLE_NLS=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TOOLCHAIN_GLIBC_GCONV_LIBS_COPY=y
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

        # Variables for this test.
        dev = "/dev/vda"
        label = "BR_TEST"
        mnt_pt = "/tmp/vfat"
        data_file = f"{mnt_pt}/data.bin"

        # We create the vfat filesystem on our device.
        self.assertRunOk(f"mkfs.vfat {dev}")

        # We set a label on this filesystem.
        self.assertRunOk(f"fatlabel {dev} '{label}'")

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

        # We run a filesystem check. Since we cleanly unmounted the
        # filesystem, we are not expecting any repair. This is just to
        # test the program works correctly.
        self.assertRunOk(f"fsck.vfat -v {dev}")

        # We query the label and check it is the one we set at the
        # beginning.
        out, ret = self.emulator.run(f"fatlabel {dev}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], label)

        # We remount our filesystem.
        self.assertRunOk(f"mount {dev} {mnt_pt}")

        # We should recompute the same sha256 hash as before, on the
        # first data file we created at the beginning.
        out, ret = self.emulator.run(hash_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], data_sha256)
