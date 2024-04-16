import os

import infra.basetest


class TestNu(infra.basetest.BRTest):
    # infra.basetest.BASIC_TOOLCHAIN_CONFIG cannot be used as it doesn't
    # support a host rustc which is necessary for nushell
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_NEON=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_SYSTEM_DHCP="eth0"
        BR2_PACKAGE_NUSHELL=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="{}"
        BR2_ROOTFS_POST_SCRIPT_ARGS="{}"
        """.format(infra.filepath("tests/package/copy-sample-script-to-target.sh"),
                   infra.filepath("tests/package/sample_nu.nu"))

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7",
                           kernel="builtin",
                           options=["-initrd", img])
        self.emulator.login()
        cmd = "nu sample_nu.nu"
        self.assertRunOk(cmd)
