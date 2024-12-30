import os

import infra.basetest


class TestXxHash(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_XXHASH=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        testfile = "data.bin"

        # Check we can run the program.
        self.assertRunOk("xxhsum --version")

        # We create a test data file with random data.
        cmd = f"dd if=/dev/urandom of={testfile} bs=1M count=1"
        self.assertRunOk(cmd)

        # For the three hash sizes, we compute the xxhash and check
        # the integrity of the file.
        for hsize in [32, 64, 128]:
            hashfile = f"{testfile}.xxh{hsize}"
            self.assertRunOk(f"xxh{hsize}sum {testfile} | tee {hashfile}")
            self.assertRunOk(f"xxh{hsize}sum -c {hashfile}")
