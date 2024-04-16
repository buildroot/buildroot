import os

import infra.basetest


class TestDdrescue(infra.basetest.BRTest):

    # A specific configuration is needed for testing ddrescue:
    # - A kernel config fragment enables loop blk dev and device
    #   mapper dm-dust, which are used to simulate a failing storage
    #   block device.
    # - dmraid user space package is needed to configure dm-dust
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.1.15"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_CONFIG_FRAGMENT_FILES="{}"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_PACKAGE_DDRESCUE=y
        BR2_PACKAGE_DMRAID=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
            infra.filepath("tests/package/test_ddrescue/linux-ddrescue.fragment")
        )

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "256M", "-initrd", img])
        self.emulator.login()

        # Test variables:
        dev_img = "/tmp/dev.img"
        lo_dev = "/dev/loop0"
        dm_dev_name = "dust0"
        dm_dev = f"/dev/mapper/{dm_dev_name}"
        ddrescue_img = "/tmp/ddrescue.img"

        # Test the program can execute
        self.assertRunOk("ddrescue --version")

        # Create a 1MB file of zeroes for initial loopback block device
        self.assertRunOk(f"dd if=/dev/zero of={dev_img} bs=1M count=1")

        # Setup lookback block device
        self.assertRunOk(f"losetup {lo_dev} {dev_img}")

        # Create and setup dm-dust to simulate a failing block device
        # The dev_img file is 1MB: 2048 blocks of 512 bytes each
        self.assertRunOk(f"dmsetup create {dm_dev_name} --table '0 2048 dust {lo_dev} 0 512'")

        # Add few bad blocks and enable I/O error emulation
        for badblock in [30, 40, 50, 60]:
            self.assertRunOk(f"dmsetup message {dm_dev_name} 0 addbadblock {badblock}")
        self.assertRunOk(f"dmsetup message {dm_dev_name} 0 enable")

        # Show device mapper status, to make debugging easier
        self.assertRunOk(f"dmsetup status {dm_dev_name}")

        # A normal 'dd' is expected to fail with I/O error
        cmd = f"dd if={dm_dev} of=/dev/null bs=512"
        _, exit_code = self.emulator.run(cmd)
        self.assertNotEqual(exit_code, 0)

        # Where a normal 'dd' fails, 'ddrescue' is expected to succeed
        self.assertRunOk(f"ddrescue {dm_dev} {ddrescue_img}")

        # ddrescue does not normaly write any output data when there
        # is I/O error on the input. The intent is to preserve any
        # data that could have been read in a previous pass. There is
        # one exception, when the output is a non-existing regular
        # file, ddrescue will initialize it with zeroes the first
        # time. Since the original image file was also including
        # zeroes, the recovered image is expected to be the same as
        # the original one. See ddrescue manual:
        # https://www.gnu.org/software/ddrescue/manual/ddrescue_manual.html#Introduction
        # "Ddrescue does not write zeros to the output when it finds
        # bad sectors in the input, and does not truncate the output
        # file if not asked to."
        # https://www.gnu.org/software/ddrescue/manual/ddrescue_manual.html#Algorithm
        # "If the output file is a regular file created by ddrescue,
        # the areas marked as bad-sector will contain zeros."
        self.assertRunOk(f"cmp {dev_img} {ddrescue_img}")
