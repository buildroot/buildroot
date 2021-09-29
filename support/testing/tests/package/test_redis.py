import os

import infra.basetest


class TestRedis(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + """
    BR2_TARGET_ROOTFS_CPIO=y
    BR2_PACKAGE_REDIS=y
    """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("redis-cli SET hello world")

        output, exit_code = self.emulator.run("redis-cli GET hello")
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0].strip(), '"world"')
