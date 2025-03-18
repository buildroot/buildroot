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

        # Now, check we can reach an arbitrary registry: quay.io
        output, _ = self.emulator.run(
            "skopeo inspect docker://quay.io/quay/busybox:latest",
            timeout=60,
        )
        skopeo_info = json.loads("".join(output))
        self.assertEqual(skopeo_info["Name"], "quay.io/quay/busybox")
