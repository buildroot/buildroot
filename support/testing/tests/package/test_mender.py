import os

import infra.basetest


# gitlab-runner: large
class TestMenderInfra(infra.basetest.BRTest):
    # infra.basetest.BASIC_TOOLCHAIN_CONFIG cannot be used as it does
    # not include BR2_TOOLCHAIN_SUPPORTS_ALWAYS_LOCKFREE_ATOMIC_INTS
    # needed by mender. This config also uses an ext4 rootfs as
    # the default 128MB is too small for an image with mender and systemd.
    config = \
        """
        BR2_x86_64=y
        BR2_x86_corei7=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN_X86_64_CORE_I7_GLIBC_STABLE=y
        BR2_INIT_SYSTEMD=y
        BR2_SYSTEM_DHCP="eth0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="6.18.59"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/mender/x86_64/linux.config"
        BR2_PACKAGE_MENDER=y
        BR2_ROOTFS_POST_BUILD_SCRIPT="{}"
        BR2_ROOTFS_OVERLAY="{}"
        BR2_PACKAGE_HOST_MENDER_ARTIFACT=y
        BR2_TARGET_ROOTFS_EXT2=y
        BR2_TARGET_ROOTFS_EXT2_4=y
        BR2_TARGET_ROOTFS_EXT2_SIZE="256M"
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
           infra.filepath("tests/package/test_mender/post-build.sh"),
           # overlay to add a fake 'fw_printenv', used by Mender
           infra.filepath("tests/package/test_mender/rootfs-overlay"))

    def base_test_run(self):
        drive = os.path.join(self.builddir, "images", "rootfs.ext4")
        kern = os.path.join(self.builddir, "images", "bzImage")
        self.emulator.boot(arch="x86_64",
                           kernel=kern,
                           kernel_cmdline=["root=/dev/vda console=ttyS0 net.ifnames=0"],
                           options=["-cpu", "Nehalem",
                                    "-m", "256M",
                                    "-net", "nic,model=virtio",
                                    "-net", "user",
                                    "-drive", f"file={drive},if=virtio,format=raw"])
        self.emulator.login()

    def run_mender_test(self):

        # mender-authd requires systemd-resolved.service to be up,
        # so wait for eth0 to get its DHCP address before querying.
        cmd = "while ! ifconfig eth0 | grep -q 'inet addr'; do sleep 1; done"
        self.assertRunOk(cmd, timeout=30)

        output, _ = self.emulator.run("systemctl is-active mender-updated")
        self.assertEqual(output[0], "active")

        # Check if a simple Mender command is correctly executed
        self.assertRunOk("mender-update --log-level debug show-artifact")
        self.assertRunOk("mender-update --log-level debug show-artifact | grep 'RUNTIME_TEST_ARTIFACT_NAME'")
        cmd = "mender-update show-artifact 2>&1 | grep -i 'err'"  # Check if no 'error' among the traces
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 1)


class TestMenderRO(TestMenderInfra):
    config = \
        """
        {}
        # BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW is not set
        """.format(TestMenderInfra.config)

    def test_run(self):
        TestMenderInfra.base_test_run(self)
        self.run_mender_test()
