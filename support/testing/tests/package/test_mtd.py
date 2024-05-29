import os

import infra.basetest


class TestMtd(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_MTD=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_ROOTFS_CPIO=y
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])

        self.emulator.login()

        mtd = "/dev/mtd0"
        erasesize = 256 * 1024
        test_sectors = 4
        test_size = erasesize * test_sectors

        output, exit_code = self.emulator.run(f"mtd_debug info {mtd}")
        output = [x.strip() for x in output if x.strip()]
        self.assertEqual(output, [
            "mtd.type = MTD_NORFLASH",
            "mtd.flags = MTD_CAP_NORFLASH",
            "mtd.size = 134217728 (128M)",
            "mtd.erasesize = 262144 (256K)",
            "mtd.writesize = 1",
            "mtd.oobsize = 0",
            "regions = 0",
        ])

        # Test flashcp
        self.assertRunOk(f"dd if=/dev/urandom of=random.bin bs={test_size} count=1")
        self.assertRunOk(f"flashcp random.bin {mtd}")
        self.assertRunOk(f"cmp -s -n {test_size} random.bin {mtd}")

        # Test flash_erase
        self.assertRunOk(f"dd if=/dev/zero bs={test_size} count=1 | tr '\\000' '\\377' >nor-erase.bin")
        self.assertRunOk(f"flash_erase {mtd} 0 {test_sectors}")
        self.assertRunOk(f"cmp -s -n {test_size} nor-erase.bin {mtd}")
