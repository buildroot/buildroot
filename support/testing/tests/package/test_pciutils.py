import os

import infra.basetest


class TestPCIUtils(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_PCIUTILS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")

        # Note: we add a qemu pci-testdev in order to have a stable
        # device ID, and for writing in configuration space without
        # interfering with the rest of the emulation. See:
        # https://www.qemu.org/docs/master/specs/pci-testdev.html
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file,
                                    "-device", "pci-testdev"])
        self.emulator.login()

        # Check the program executes. This test also check that we
        # have "lspci" from the pciutils package, rather than the
        # busybox applet (which does not recognize the --version
        # option)"
        self.assertRunOk("lspci --version")

        # Check few program invocations.
        self.assertRunOk("lspci")
        for lspci_opt in ["-t", "-n", "-v", "-vv", "-x"]:
            self.assertRunOk(f"lspci {lspci_opt}")

        # Check we can see the qemu pci-testdev.
        # Vendor: 1b36: Red Hat, Inc.
        # Device: 0005: QEMU PCI Test Device
        pci_vendor_id = "1b36"
        pci_device_id = "0005"
        pci_dev = f"{pci_vendor_id}:{pci_device_id}"
        cmd = f"lspci -d {pci_dev}"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertIn("Red Hat, Inc.", output[0])
        self.assertIn("QEMU PCI Test Device", output[0])

        # We disable INTx emulation by setting bit 10 of the COMMAND
        # register in the configuration space. See:
        # https://git.kernel.org/pub/scm/utils/pciutils/pciutils.git/tree/lib/header.h?h=v3.10.0#n26
        dis_int_x = 0x400
        data_mask = f"{hex(dis_int_x)}:{hex(dis_int_x)}"
        cmd = f"setpci -d {pci_dev} COMMAND.w={data_mask}"
        self.assertRunOk(cmd)

        # We read back and check the value.
        cmd = f"setpci -d {pci_dev} COMMAND.w"
        output, exit_code = self.emulator.run(cmd)
        read_value = int(output[0], 16)
        self.assertEqual(exit_code, 0)
        self.assertTrue((read_value & dis_int_x) == dis_int_x)

        # We check lspci now see the disabled INTx emulation.
        cmd = f"lspci -vv -d {pci_dev} | grep -F 'DisINTx+'"
        self.assertRunOk(cmd)

        # We re-enable the INTx emulation by clearing the bit 10.
        data_mask = f"0x0:{hex(dis_int_x)}"
        cmd = f"setpci -d {pci_dev} COMMAND.w={data_mask}"
        self.assertRunOk(cmd)

        # We read back and check the value, again.
        cmd = f"setpci -d {pci_dev} COMMAND.w"
        output, exit_code = self.emulator.run(cmd)
        read_value = int(output[0], 16)
        self.assertEqual(exit_code, 0)
        self.assertTrue((read_value & dis_int_x) == 0)

        # We check lspci now see the enabled INTx emulation.
        cmd = f"lspci -vv -d {pci_dev} | grep -F 'DisINTx-'"
        self.assertRunOk(cmd)
