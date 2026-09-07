import os

import infra.basetest


class TestOpenSCAPBase(infra.basetest.BRTest):
    config = """
        BR2_arm=y
        BR2_cortex_a8=y
        BR2_ARM_EABIHF=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_ARMV7_EABIHF_GLIBC_STABLE=y
        BR2_PACKAGE_OPENSCAP=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
                infra.filepath("tests/package/test_openscap/rootfs-overlay"))

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(
            arch="armv7",
            kernel="builtin",
            options=["-m", "512M", "-initrd", cpio_file],
        )
        self.emulator.login()

        out, ret = self.emulator.run("oscap --version")
        self.assertEqual(ret, 0)

        out, ret = self.emulator.run("oscap info /root/benchmark.xml")
        self.assertEqual(ret, 0)
        self.assertIn("Document type: XCCDF Checklist", "\n".join(out))


class TestOpenSCAPGcrypt(TestOpenSCAPBase):
    """Test openscap using the gcrypt crypto backend."""

    config = (
        TestOpenSCAPBase.config
        + """
        BR2_PACKAGE_LIBGCRYPT=y
        """
    )


class TestOpenSCAPNss(TestOpenSCAPBase):
    """Test openscap using the nss crypto backend."""

    config = (
        TestOpenSCAPBase.config
        + """
        BR2_PACKAGE_LIBNSS=y
        """
    )


class TestOpenSCAPNoCrypto(TestOpenSCAPBase):
    """Test openscap without any crypto backend."""

    config = TestOpenSCAPBase.config
