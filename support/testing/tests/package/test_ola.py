import os

import infra.basetest


class TestOla(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_OLA=y
        BR2_PACKAGE_OLA_EXAMPLES=y
        BR2_PACKAGE_OLA_PLUGIN_DUMMY=y
        BR2_PACKAGE_OLA_PYTHON_BINDINGS=y
        BR2_PACKAGE_OLA_WEB=y
        BR2_PACKAGE_PYTHON3=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
           # overlay to add a script to test ola python bindings
           infra.filepath("tests/package/test_ola/rootfs-overlay"))

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check program executes
        cmd = "olad --version"
        self.assertRunOk(cmd)

        # Start the daemon and wait a bit for it to settle
        cmd = "olad --daemon && sleep 2"
        self.assertRunOk(cmd)

        # Check dummy plugin is loaded
        cmd = "ola_plugin_info | grep -Fi dummy"
        self.assertRunOk(cmd)

        # Check dummy device and port are listed
        cmd = "ola_dev_info"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn("Device 1: Dummy Device", output[0])
        self.assertIn("port 0, OUT Dummy Port", output[1])

        # Create Universe 0
        cmd = "ola_patch --device 1 --port 0 --universe 0"
        self.assertRunOk(cmd)

        # Check Universe 0 is created
        cmd = "ola_dev_info"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn("patched to universe 0", output[1])

        # Discover Dummy device RDM UID
        cmd = "ola_rdm_discover --universe 0 | head -1"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        rdm_uid = output[0]

        # Get RDM manufacturer_label PID
        cmd = "ola_rdm_get --universe 0 --uid {} manufacturer_label".format(rdm_uid)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "Open Lighting Project")

        # Get RDM dmx_start_address PID, checks default value is 1
        cmd = "ola_rdm_get --universe 0 --uid {} dmx_start_address".format(rdm_uid)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "DMX Address: 1")

        # Set RDM dmx_start_address PID to 2
        cmd = "ola_rdm_set --universe 0 --uid {} dmx_start_address 2".format(rdm_uid)
        self.assertRunOk(cmd)

        # Get the new RDM dmx_start_address PID, checks value is now 2
        cmd = "ola_rdm_get --universe 0 --uid {} dmx_start_address".format(rdm_uid)
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "DMX Address: 2")

        # Perform a full RDM discovery using python bindings. The test
        # expect to find the same UID detected with the C client.
        cmd = "sample_ola_rdm_discovery.py | head -1"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], rdm_uid)

        # Test olad web interface
        cmd = "wget -q -O - http://127.0.0.1:9090/ola.html | grep -F '<title>OLA Admin</title>'"
        self.assertRunOk(cmd)
