import os
import json

import infra.basetest


class TestHardeningBase(infra.basetest.BRTest):
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_AARCH64_GLIBC_STABLE=y
        BR2_PACKAGE_LIGHTTPD=y
        BR2_PACKAGE_HOST_CHECKSEC=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    checksec_files = ["usr/sbin/lighttpd", "bin/busybox"]

    def checksec_run(self, target_file):
        filepath = os.path.join(self.builddir, "target", target_file)
        cmd = ["host/bin/checksec", "--format=json",
               "--file={}".format(filepath)]
        # Checksec is being used for elf file analysis only.  There are no
        # assumptions of target/run-time checks as part of this testing.
        ret = infra.run_cmd_on_host(self.builddir, cmd)
        return json.loads(ret)


class TestRelro(TestHardeningBase):
    config = TestHardeningBase.config + \
        """
        BR2_RELRO_FULL=y
        """

    def test_run(self):
        for f in self.checksec_files:
            out = self.checksec_run(f)
            filepath = os.path.join(self.builddir, "target", f)
            self.assertEqual(out[filepath]["relro"], "full")
            self.assertEqual(out[filepath]["pie"], "yes")


class TestRelroPartial(TestHardeningBase):
    config = TestHardeningBase.config + \
        """
        BR2_RELRO_PARTIAL=y
        # BR2_PIC_PIE is not set
        """

    def test_run(self):
        for f in self.checksec_files:
            out = self.checksec_run(f)
            filepath = os.path.join(self.builddir, "target", f)
            self.assertEqual(out[filepath]["relro"], "partial")
            self.assertEqual(out[filepath]["pie"], "no")


class TestSspNone(TestHardeningBase):
    config = TestHardeningBase.config + \
        """
        BR2_SSP_NONE=y
        """

    def test_run(self):
        for f in self.checksec_files:
            out = self.checksec_run(f)
            filepath = os.path.join(self.builddir, "target", f)
            self.assertEqual(out[filepath]["canary"], "no")


class TestSspStrong(TestHardeningBase):
    config = TestHardeningBase.config + \
        """
        BR2_SSP_STRONG=y
        """

    def test_run(self):
        for f in self.checksec_files:
            out = self.checksec_run(f)
            filepath = os.path.join(self.builddir, "target", f)
            self.assertEqual(out[filepath]["canary"], "yes")


class TestFortifyNone(TestHardeningBase):
    config = TestHardeningBase.config + \
        """
        BR2_FORTIFY_SOURCE_NONE=y
        """

    def test_run(self):
        for f in self.checksec_files:
            out = self.checksec_run(f)
            filepath = os.path.join(self.builddir, "target", f)
            self.assertEqual(out[filepath]["fortified"], "0")


class TestFortifyConserv(TestHardeningBase):
    config = TestHardeningBase.config + \
        """
        BR2_FORTIFY_SOURCE_1=y
        """

    def test_run(self):
        for f in self.checksec_files:
            out = self.checksec_run(f)
            filepath = os.path.join(self.builddir, "target", f)
            self.assertNotEqual(out[filepath]["fortified"], "0")
