import infra.basetest
import json
import os


class TestSkopeo(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PER_PACKAGE_DIRECTORIES=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_PACKAGE_CA_CERTIFICATES=y
        BR2_PACKAGE_SKOPEO=y
        BR2_PACKAGE_HOST_GO_BIN=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file, "-nic", "user,model=rtl8139"])
        self.emulator.login()

        self.assertRunOk("skopeo --version", timeout=30)

        # First, check we can reach the default registry: docker.io
        output, _ = self.emulator.run(
            "skopeo inspect docker://busybox:latest",
            timeout=60,
        )
        bb_info = json.loads("".join(output))
        self.assertEqual(bb_info["Name"], "docker.io/library/busybox")

        # Then check we can retrieve the image from the default registry
        # Copy all archs in the image to check we can enumerate those (inspect
        # does not enumerate all archs)
        self.assertRunOk(
            "skopeo copy -a docker://busybox:latest oci-archive:busybox-latest.oci",
            timeout=120,
        )

        # Check we can inspect a local OCI archive
        self.assertRunOk(
            "skopeo inspect oci-archive:busybox-latest.oci",
            timeout=30,
        )

        # Now, check we can reach an arbitrary registry: quay.io
        output, _ = self.emulator.run(
            "skopeo inspect docker://quay.io/quay/busybox:latest",
            timeout=60,
        )
        skopeo_info = json.loads("".join(output))
        self.assertEqual(skopeo_info["Name"], "quay.io/quay/busybox")

        # Finally check we can retrieve the image from an arbitrary registry
        self.assertRunOk(
            "skopeo copy docker://quay.io/quay/busybox:latest oci-archive:busybox-quay.io-latest.oci",
            timeout=120,
        )
