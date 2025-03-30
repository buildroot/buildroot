import os

import infra.basetest


class TestHyperfine(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_HYPERFINE=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("hyperfine --version")

        test_cmd = "sleep 0.1"
        cmd = f"hyperfine --style basic --runs 10 '{test_cmd}'"
        self.assertRunOk(cmd, timeout=15)
