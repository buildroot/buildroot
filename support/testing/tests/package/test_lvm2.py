import os
import subprocess

import infra.basetest


class TestLvm2(infra.basetest.BRTest):
    # The lvm2 package has _LINUX_CONFIG_FIXUPS, so we cannot use
    # the runtime test pre-built Kernel. We need to compile a Kernel
    # to make sure it will include the required configuration.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.77"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_E2FSPROGS=y
        BR2_PACKAGE_E2FSPROGS_RESIZE2FS=y
        BR2_PACKAGE_LVM2=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def get_free_disk_space(self, path):
        out, ret = self.emulator.run(f"df -k {path}")
        self.assertEqual(ret, 0)
        return int(out[1].split()[3])

    def test_run(self):
        # Test configuration:
        storage_devs = ["/dev/vda", "/dev/vdb", "/dev/vdc"]
        storage_size = 16                       # Mega Bytes
        lvm_vg = "br_vg"                        # Volume Group name
        lvm_lv = "br_lv"                        # Logical Volume name
        lv_dev = f"/dev/{lvm_vg}/{lvm_lv}"      # Logical Volume dev name
        mnt_pt = "/mnt/lvm2-storage"
        data_file = f"{mnt_pt}/data.bin"

        qemu_storage_opts = []
        for i in range(len(storage_devs)):
            disk_file = os.path.join(self.builddir, "images", f"disk{i}.img")
            self.emulator.logfile.write(f"Creating disk image: {disk_file}\n")
            self.emulator.logfile.flush()
            subprocess.check_call(
                ["dd", "if=/dev/zero", f"of={disk_file}",
                 "bs=1M", f"count={storage_size}"],
                stdout=self.emulator.logfile,
                stderr=self.emulator.logfile)
            opts = ["-drive", f"file={disk_file},if=virtio,format=raw"]
            qemu_storage_opts += opts

        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M",
                                    "-initrd", img] + qemu_storage_opts)
        self.emulator.login()

        # Test the program can execute.
        self.assertRunOk("lvm version")

        # We did not created any Physical Volume yet. We should NOT
        # see any of our storage devices in a pvscan.
        out, ret = self.emulator.run("pvscan")
        self.assertEqual(ret, 0)
        for dev in storage_devs:
            self.assertNotIn(dev, "\n".join(out))

        # We initialize our Physical Volumes (PVs).
        pv_devs = " ".join(storage_devs)
        self.assertRunOk(f"pvcreate {pv_devs}")

        # We run few diagnostic commands related to PVs.
        self.assertRunOk(f"pvck {pv_devs}")
        self.assertRunOk(f"pvdisplay {pv_devs}")
        self.assertRunOk("pvs")

        # Now we initialized the PVs, we should see them in a pvscan.
        out, ret = self.emulator.run("pvscan")
        self.assertEqual(ret, 0)
        for dev in storage_devs:
            self.assertIn(dev, "\n".join(out))

        # We create a Volume Group (VG) including two of our three
        # PVs.
        cmd = f"vgcreate {lvm_vg} {storage_devs[0]} {storage_devs[1]}"
        self.assertRunOk(cmd)

        # We run few diagnostic commands related to VGs.
        self.assertRunOk(f"vgck {lvm_vg}")
        self.assertRunOk(f"vgdisplay {lvm_vg}")
        self.assertRunOk("vgscan")
        self.assertRunOk("vgs")

        # We create a Logical Volume (LV) in our VG.
        self.assertRunOk(f"lvcreate -l 100%FREE -n {lvm_lv} {lvm_vg}")

        # We check LVM created the LV device.
        self.assertRunOk(f"ls -al {lv_dev}")

        # We run few diagnostic commands related to LVs.
        self.assertRunOk("lvscan")
        self.assertRunOk("lvs")

        # We create a ext4 filesystem on our LV.
        self.assertRunOk(f"mkfs.ext4 {lv_dev}")

        # We create a mount point directory and mount the device.
        self.assertRunOk(f"mkdir -p {mnt_pt}")
        self.assertRunOk(f"mount {lv_dev} {mnt_pt}")

        # We create a data file in our new filesystem. Note: this file
        # is slightly larger than a single PV. This data file should
        # span over the two PVs in the VG.
        data_size = storage_size + 4
        cmd = f"dd if=/dev/urandom of={data_file} bs=1M count={data_size}"
        self.assertRunOk(cmd)

        # We compute the hash of our data, and save it for later.
        hash_cmd = f"sha256sum {data_file}"
        out, ret = self.emulator.run(hash_cmd)
        self.assertEqual(ret, 0)
        data_sha256 = out[0]

        # We compute the free space of the mount point.
        fs_free_space = self.get_free_disk_space(mnt_pt)

        # We extend of VG with our third PV.
        self.assertRunOk(f"vgextend {lvm_vg} {storage_devs[2]}")

        # We grow the LV to use all the space of the VG.
        self.assertRunOk(f"lvresize -l +100%FREE {lvm_vg}/{lvm_lv}")

        # We resize the filesystem to use all the LV space.
        self.assertRunOk(f"resize2fs {lv_dev}")

        # Now we grew the LV and resized the filesystem, we recompute
        # the free space and check we have more.
        fs2_free_space = self.get_free_disk_space(mnt_pt)
        self.assertGreater(fs2_free_space, fs_free_space)

        # With all those on-the-fly operations on the mounted
        # filesystem, the data file should be intact. We should
        # recompute the same data checksum as before.
        out, ret = self.emulator.run(hash_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], data_sha256)

        # Finally, we unmount the filesystem. It should not contain
        # any error.
        self.assertRunOk(f"umount {mnt_pt}")
        self.assertRunOk(f"e2fsck -f -n {lv_dev}")
