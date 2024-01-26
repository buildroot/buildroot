import os
import subprocess

import infra.basetest


class TestCryptSetup(infra.basetest.BRTest):
    # A specific configuration is needed for using cryptsetup:
    # - A kernel config fragment enables all the parts needed for
    #   mounting a LUKS2 volume,
    # - Enable OpenSSL for cryptsetup crypto backend library,
    # - Enable e2fsprog for formatting a ext4 filesystem.
    kern_frag = \
        infra.filepath("tests/package/test_cryptsetup/linux-cryptsetup.fragment")
    config = \
        f"""
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.75"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_CRYPTSETUP=y
        BR2_PACKAGE_E2FSPROGS=y
        BR2_PACKAGE_OPENSSL=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        disk_file = os.path.join(self.builddir, "images", "disk.img")
        self.emulator.logfile.write(f"Creating disk image: {disk_file}")
        subprocess.check_call(
            ["dd", "if=/dev/urandom", f"of={disk_file}", "bs=1M", "count=20"],
            stdout=self.emulator.logfile,
            stderr=self.emulator.logfile)

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

        # Check the program can execute.
        self.assertRunOk("cryptsetup --version")

        passkey = "ThisIsAPassKey."
        dev = "/dev/vda"
        dm_name = "luks-vol"
        dm_dev = f"/dev/mapper/{dm_name}"
        mnt_pt = "/mnt/secure-volume"

        # Check the device is NOT detected as a LUKS volume, because
        # it is not formatted yet.
        is_luks_cmd = f"cryptsetup isLuks {dev}"
        _, ret = self.emulator.run(is_luks_cmd)
        self.assertNotEqual(ret, 0)

        # Format the LUKS volume.
        cmd = f"echo {passkey} | cryptsetup luksFormat {dev}"
        self.assertRunOk(cmd, timeout=30)

        # Check the device is now detected as a LUKS device.
        self.assertRunOk(is_luks_cmd)

        # Dump LUKS device header information.
        self.assertRunOk(f"cryptsetup luksDump {dev}")

        # Open the LUKS device
        luks_open_cmd = f"echo {passkey} | "
        luks_open_cmd += f"cryptsetup open --type luks {dev} {dm_name}"
        self.assertRunOk(luks_open_cmd, timeout=10)

        # Create an ext4 filesystem.
        self.assertRunOk(f"mke2fs -T ext4 {dm_dev}", timeout=10)

        # Create the mount point directory.
        self.assertRunOk(f"mkdir {mnt_pt}")

        # Mount the LUKS device.
        mount_cmd = f"mount {dm_dev} {mnt_pt}"
        self.assertRunOk(mount_cmd)

        # Create a plain text file in the mounted filesystem.
        msg = "This is a plain text message"
        plain_file = f"{mnt_pt}/file.txt"
        self.assertRunOk(f"echo '{msg}' > {plain_file}")

        # Unmount.
        self.assertRunOk(f"umount {mnt_pt}")

        # We are supposed to see our plain text message on the
        # dm-crypt device.
        self.assertRunOk(f"grep -Fq '{msg}' {dm_dev}", timeout=10)

        # Close the LUKS device
        self.assertRunOk(f"cryptsetup close {dm_name}")

        # We are NOT supposed to find our plain text message on the
        # crypted storage device.
        _, ret = self.emulator.run(f"grep -Fq '{msg}' {dev}", timeout=10)
        self.assertNotEqual(ret, 0)

        # Try to open LUKS volume with a wrong password. This is
        # expected to fail.
        cmd = f"echo 'Wrong{passkey}' | "
        cmd += f"cryptsetup open --type luks {dev} {dm_name}"
        _, ret = self.emulator.run(cmd, timeout=10)
        self.assertNotEqual(ret, 0)

        # Check the device-mapper device was NOT created (since we
        # tried to open it with a wrong password).
        self.assertRunOk(f"test ! -e {dm_dev}")

        # Reopen the LUKS device, with the good passkey this time...
        self.assertRunOk(luks_open_cmd, timeout=10)

        # ...remount...
        self.assertRunOk(mount_cmd)

        # ...and read back our plain text file. We check we get back
        # our original message.
        out, ret = self.emulator.run(f"cat {plain_file}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)
