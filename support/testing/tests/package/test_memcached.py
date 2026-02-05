import os

import infra.basetest


class TestMemcached(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + """
    BR2_TARGET_ROOTFS_CPIO=y
    BR2_PACKAGE_MEMCACHED=y
    BR2_PACKAGE_NETCAT=y
    BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
    """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        output, exit_code = self.emulator.run("memcached -u root &")

        set_key_cmd = "set test_key 0 100 10\\r\\ntest_value\\r\\nquit\\r\\n"
        output, exit_code = self.emulator.run(
            f"echo -ne '{set_key_cmd}' | nc localhost 11211"
        )
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0].strip(), 'STORED')

        get_key_cmd = "get test_key\\r\\nquit\\r\\n"
        output, exit_code = self.emulator.run(
            f"echo -ne '{get_key_cmd}' | nc localhost 11211"
        )
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[2].strip(), 'test_value')
