import os
import infra
import subprocess

from infra.basetest import BRTest


class TestBmapTools(BRTest):
    __test__ = False
    sample_script = "tests/package/sample_bmap_tools.sh"
    copy_script = 'tests/package/copy-sample-script-to-target.sh'
    config = \
        """
        BR2_arm=y
        BR2_cortex_a8=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PACKAGE_BMAP_TOOLS=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="{}"
        BR2_ROOTFS_POST_SCRIPT_ARGS="{}"
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="65536"
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_UTIL_LINUX=y
        BR2_PACKAGE_UTIL_LINUX_FALLOCATE=y
        BR2_PACKAGE_E2FSPROGS=y
        BR2_PACKAGE_UTIL_LINUX_LIBUUID=y
        """.format(infra.filepath(copy_script),
                   infra.filepath(sample_script))
    timeout = 60

    def login(self):
        img = os.path.join(self.builddir, "images", "rootfs.ext4")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           kernel_cmdline=["root=/dev/mmcblk0",
                                           "rootfstype=ext4"],
                           options=["-drive", "file={},if=sd,format=raw".format(img)])
        self.emulator.login()

    def test_run(self):
        self.login()
        cmd = "/root/{}".format(os.path.basename(self.sample_script))
        self.assertRunOk(cmd, timeout=20)


class TestPy2BmapTools(TestBmapTools):
    __test__ = True
    config = TestBmapTools.config + \
        """
        BR2_PACKAGE_PYTHON=y
        """


class TestPy3BmapTools(TestBmapTools):
    __test__ = True
    config = TestBmapTools.config + \
        """
        BR2_PACKAGE_PYTHON3=y
        """


class TestHostBmapTools(BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_HOST_BMAP_TOOLS=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_TARGET_ROOTFS_EXT2=y
        """

    def test_run(self):
        bmap_x = os.path.join(self.b.builddir, "host", "bin", "bmaptool")
        src_f = os.path.join(self.b.builddir, "images", "rootfs.ext2")
        dst_f = os.path.join(self.b.builddir, "images", "rootfs.ext2.copy")
        map_f = os.path.join(self.b.builddir, "images", "rootfs.ext2.bmap")

        ret = subprocess.call([bmap_x, "create", "-o", map_f, src_f],
                              stdout=self.b.logfile,
                              stderr=self.b.logfile)
        self.assertEqual(ret, 0)

        ret = subprocess.call([bmap_x, "copy", src_f, dst_f],
                              stdout=self.b.logfile,
                              stderr=self.b.logfile)
        self.assertEqual(ret, 0)

        with open(src_f, 'rb') as f:
            src = f.read()
        with open(dst_f, 'rb') as f:
            dst = f.read()
        self.assertEqual(src, dst)
