import os
import subprocess
import time

import infra.basetest


class TestMdadm(infra.basetest.BRTest):
    # This test creates a dm-raid volume with mdadm. A specific Kernel
    # need to be built with a config fragment enabling this support.
    kernel_fragment = \
        infra.filepath("tests/package/test_mdadm/linux-mdadm.fragment")
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
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kernel_fragment}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_E2FSPROGS=y
        BR2_PACKAGE_MDADM=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        # Test configuration:
        md_dev = "/dev/md0"
        storage_devs = ["/dev/vda", "/dev/vdb", "/dev/vdc"]
        storage_size = 16  # Mega Bytes
        failing_dev = storage_devs[-1]
        mnt_pt = "/mnt/raid-storage"
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
        self.assertRunOk("mdadm --version")

        # Show the mdstat, to confirm the Kernel has support and the
        # configuration is empty.
        cat_mdstat_cmd = "cat /proc/mdstat"
        self.assertRunOk(cat_mdstat_cmd)

        # We create a raid5 array with the drives.
        cmd = f"mdadm --create --verbose {md_dev} --level=5 "
        cmd += f"--raid-devices={len(storage_devs)} "
        cmd += " ".join(storage_devs)
        self.assertRunOk(cmd)

        # We show again mdstat, to confirm the array creation. This is
        # also for debugging.
        self.assertRunOk(cat_mdstat_cmd)

        # We format the device as ext4 and mount it.
        self.assertRunOk(f"mkfs.ext4 {md_dev}")
        self.assertRunOk(f"mkdir -p {mnt_pt}")
        self.assertRunOk(f"mount {md_dev} {mnt_pt}")

        # We store some random data on this new filesystem. Note: this
        # file is slightly larger than a single storage drive. This
        # data file should span over two drives and use the raid5.
        file_size = storage_size + 4
        cmd = f"dd if=/dev/urandom of={data_file} bs=1M count={file_size}"
        self.assertRunOk(cmd)

        # We compute the hash of our data, and save it for later.
        hash_cmd = f"sha256sum {data_file}"
        out, ret = self.emulator.run(hash_cmd)
        self.assertEqual(ret, 0)
        data_sha256 = out[0]

        # We run few common mdadm commands.
        self.assertRunOk("mdadm --detail --scan")
        self.assertRunOk(f"mdadm --query {md_dev}")
        self.assertRunOk(f"mdadm --detail --test {md_dev}")
        self.assertRunOk(f"mdadm --action=check {md_dev}")
        self.assertRunOk(f"mdadm --monitor --oneshot {md_dev}")

        # We mark a device as "failed".
        self.assertRunOk(f"mdadm {md_dev} --fail {failing_dev}")

        # The monitoring should now report the array as degraded.
        monitor_cmd = f"mdadm --monitor --oneshot {md_dev}"
        out, ret = self.emulator.run(monitor_cmd)
        self.assertEqual(ret, 0)
        self.assertIn("DegradedArray", "\n".join(out))

        # We remove the failing drive from the array.
        self.assertRunOk(f"mdadm {md_dev} --remove {failing_dev}")

        # We wipe the failing drive by writing zeroes.
        cmd = f"dd if=/dev/zero of={failing_dev} bs=1M count={storage_size}"
        self.assertRunOk(cmd)

        # We add back this blank drive to the array.
        self.assertRunOk(f"mdadm {md_dev} --add {failing_dev}")

        # Device rebuild can take a variable amount of time, depending
        # on the load of the test controller host. So we will allow
        # several attempts, before failing.
        for attempt in range(10):
            # We wait few seconds to let the device rebuild.
            time.sleep(3 * self.timeout_multiplier)

            # Once rebuilt, the array should no longer be marked as
            # degraded.
            out, ret = self.emulator.run(monitor_cmd)
            self.assertEqual(ret, 0)
            if "DegradedArray" not in "\n".join(out):
                break
        else:
            self.fail("Timeout while waiting for the array to rebuild.")

        # With all those array manipulations, the data file should not
        # be corrupted. We should be able to recompute the same hash
        # as before.
        out, ret = self.emulator.run(hash_cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], data_sha256)
