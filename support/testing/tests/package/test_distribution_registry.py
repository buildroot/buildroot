import infra.basetest
import os
import time


class TestDistributionRegistry(infra.basetest.BRTest):
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_PER_PACKAGE_DIRECTORIES=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.10.202"
        BR2_LINUX_KERNEL_DEFCONFIG="vexpress"
        BR2_LINUX_KERNEL_DTS_SUPPORT=y
        BR2_LINUX_KERNEL_INTREE_DTS_NAME="vexpress-v2p-ca9"
        BR2_PACKAGE_CA_CERTIFICATES=y
        BR2_PACKAGE_DISTRIBUTION_REGISTRY=y
        BR2_PACKAGE_SKOPEO=y
        BR2_PACKAGE_HOST_GO_BIN=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        kernel_file = os.path.join(self.builddir, "images", "zImage")
        dtb_file = os.path.join(self.builddir, "images", "vexpress-v2p-ca9.dtb")
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(
            arch="armv5",
            kernel=kernel_file,
            kernel_cmdline=[
                'console=ttyAMA0',
            ],
            options=[
                '-M', 'vexpress-a9',
                "-m", "1G",
                "-nic", "user,model=lan9118",
                "-dtb", dtb_file,
                "-initrd", cpio_file,
            ],
        )
        self.emulator.login()

        # Allow unfettered access to the local registry:
        registry_conf = "\\n".join(  # \\n to be interpreted by printf in the target
            [
                '[[registry]]',
                'location = "localhost:5000"',
                'insecure = true',
            ],
        )
        self.assertRunOk("mkdir /etc/containers/registries.conf.d")
        self.assertRunOk(
            f"printf '{registry_conf}\\n' >/etc/containers/registries.conf.d/localhost.conf",
        )

        # Check we can at least run
        self.assertRunOk("distribution-registry --version", timeout=30)

        # Spawn the registry and wait for it to be ready
        self.assertRunOk(
            "distribution-registry serve /etc/docker/registry/config.yml >/tmp/registry.log 2>&1 &",
        )
        for i in range(60):
            time.sleep(1)
            _, ret = self.emulator.run("test -s /tmp/registry.log")
            if ret == 0:
                time.sleep(2)  # Wait just a little tiny bit more...
                break
        else:
            raise SystemError("Cannot start the registry")

        # Get a multi-arch image from the Docker hub registry
        # Huge timeout because qemu-system-arm has slirp issues
        self.assertRunOk(
            "skopeo copy -a docker://busybox:1.37.0-glibc oci-archive:busybox-1.37.0-glibc.oci",
            timeout=600,
        )

        # Push the multi-arch image to the local registry
        self.assertRunOk(
            "skopeo copy -a oci-archive:busybox-1.37.0-glibc.oci docker://localhost:5000/busybox:1.37.0-glibc",
            timeout=120,
        )

        # Pull the image back
        self.assertRunOk(
            "skopeo copy -a docker://localhost:5000/busybox:1.37.0-glibc oci-archive:busybox-1.37.0-glibc-2.oci",
            timeout=120,
        )
