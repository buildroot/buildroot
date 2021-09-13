import os
import infra.basetest


class TestPolkitInfra(infra.basetest.BRTest):
    br2_external = [infra.filepath("tests/package/br2-external/polkit")]
    config = \
        """
        BR2_arm=y
        BR2_cortex_a9=y
        BR2_ARM_ENABLE_VFP=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TOOLCHAIN_EXTERNAL_BOOTLIN=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_PACKAGE_POLKIT=y
        BR2_PACKAGE_POLKIT_RULES_TEST=y
        """

    def base_test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv7", kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()


class TestPolkitSystemd(TestPolkitInfra):
    config = \
        """
        {}
        BR2_INIT_SYSTEMD=y
        BR2_PACKAGE_SYSTEMD_POLKIT=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(TestPolkitInfra.config)

    def test_run(self):
        TestPolkitInfra.base_test_run(self)

        cmd = "su brtest -c '/bin/systemctl restart systemd-timesyncd.service'"
        _, exit_code = self.emulator.run(cmd, 10)
        self.assertEqual(exit_code, 1)

        cmd = "mv /root/systemd-timesyncd-restart.rules /etc/polkit-1/rules.d"
        _, exit_code = self.emulator.run(cmd, 10)
        self.assertEqual(exit_code, 0)

        cmd = "su brtest -c '/bin/systemctl restart systemd-timesyncd.service'"
        _, exit_code = self.emulator.run(cmd, 10)
        self.assertEqual(exit_code, 0)


class TestPolkitInitd(TestPolkitInfra):
    config = TestPolkitInfra.config

    def test_run(self):
        TestPolkitInfra.base_test_run(self)

        cmd = "su brtest -c 'pkexec hello-polkit'"
        output, exit_code = self.emulator.run(cmd, 10)
        self.assertEqual(exit_code, 127)
        self.assertEqual(output[0], "Error executing command as another user: Not authorized")

        cmd = "mv /root/hello-polkit.rules /etc/polkit-1/rules.d/hello-polkit.rules"
        _, exit_code = self.emulator.run(cmd, 10)
        self.assertEqual(exit_code, 0)

        cmd = "su brtest -c 'pkexec hello-polkit'"
        output, exit_code = self.emulator.run(cmd, 10)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "Hello polkit!")
