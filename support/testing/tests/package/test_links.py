import os

import infra.basetest


class TestLinks(infra.basetest.BRTest):
    rootfs_overlay = \
        infra.filepath("tests/package/test_links/rootfs-overlay")
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_LINKS=y
        BR2_ROOTFS_OVERLAY="{rootfs_overlay}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.assertRunOk("links -version")

        expected_str = "Hello Buildroot !"
        html_file = "/root/file.html"
        url = f"file://{html_file}"

        cmd = f"links -dump {url}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        self.assertEqual(out[0].strip(), expected_str)
