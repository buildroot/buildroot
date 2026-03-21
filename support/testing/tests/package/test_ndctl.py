import json
import os

import infra.basetest


class TestNdctl(infra.basetest.BRTest):
    kern_frag = \
        infra.filepath("tests/package/test_ndctl/linux-pmem.fragment")
    config = \
        f"""
        BR2_x86_64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.19"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/x86_64/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{kern_frag}"
        BR2_LINUX_KERNEL_NEEDS_HOST_LIBELF=y
        BR2_PACKAGE_NDCTL=y
        BR2_ROOTFS_DEVICE_CREATION_DYNAMIC_EUDEV=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        kernel = os.path.join(self.builddir, "images", "bzImage")
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        pmem_file = os.path.join(self.builddir, "images", "virtio-pmem.img")
        self.emulator.boot(
            arch="x86_64",
            kernel=kernel, kernel_cmdline=["console=ttyS0"],
            options=["-M", "pc",
                     "-m", "1G,slots=2,maxmem=2G",
                     "-object", f"memory-backend-file,id=mem1,share=on,mem-path={pmem_file},size=64M",
                     "-device", "virtio-pmem-pci,memdev=mem1,id=nv1",
                     "-initrd", cpio_file]
        )
        self.emulator.login()

        # We check the program can execute.
        self.assertRunOk("ndctl --version")

        # We check we can see our pmem block device.
        self.assertRunOk("ls -l /dev/pmem0")

        # We check we can also see it with ndctl.
        out, ret = self.emulator.run("ndctl list")
        self.assertEqual(ret, 0)
        ndctl_json = "".join(out)
        pmem = json.loads(ndctl_json)
        self.assertEqual(pmem[0]["blockdev"], "pmem0")
        self.assertEqual(pmem[0]["size"], 64*1024*1024)
