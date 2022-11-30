import os

import infra.basetest


class TestPixz(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_PIXZ=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Prepare input file with random data and zeroes.
        # We keep the size small (4 MB) for the sake of test time.
        cmd = "dd if=/dev/urandom of=orig bs=1M count=2 && " \
              "dd if=/dev/zero of=orig bs=1M count=2 seek=2"
        self.assertRunOk(cmd)

        # Compress.
        # We ask for 3 threads for good measure but with a very small file on a
        # uniprocessor qemu this is only a light validation.
        cmd = "cp -v orig compressed && pixz -p 3 compressed"
        self.assertRunOk(cmd, timeout=60)

        # Uncompress.
        cmd = "cp -v compressed.xz uncompressed.xz && pixz -d uncompressed.xz"
        self.assertRunOk(cmd)

        # Verify.
        # The ls is there for debugging.
        cmd = "ls -l && cmp orig uncompressed"
        self.assertRunOk(cmd)
