import os

import infra.basetest


class TestSwupdate(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_SWUPDATE=y
        BR2_PACKAGE_HOST_SWUGENERATOR=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(infra.filepath("tests/package/test_swupdate/post-build.sh"))

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the swupdate daemon was started by the init script
        self.assertRunOk("pidof swupdate")

        # Check the embedded webserver serves the default website
        self.assertRunOk("wget -q -O - http://127.0.0.1:8080/ | grep -qi swupdate")

        # A dry run must succeed without installing anything
        self.assertRunOk("swupdate-client -d /root/test.swu", timeout=30)
        self.assertRunNotOk("test -e /tmp/swupdate-test/swupdate-test.txt")

        # Install the SWU image through the daemon
        self.assertRunOk("swupdate-client /root/test.swu", timeout=30)

        # Check the file was installed by the rawfile handler
        out, ret = self.emulator.run("cat /tmp/swupdate-test/swupdate-test.txt")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], "Hello from SWUpdate!")

        # An invalid SWU image must be rejected
        self.assertRunOk("echo garbage > /tmp/bad.swu")
        self.assertRunNotOk("swupdate-client /tmp/bad.swu", timeout=30)

        # The daemon must still be running after a failed update
        self.assertRunOk("pidof swupdate")
