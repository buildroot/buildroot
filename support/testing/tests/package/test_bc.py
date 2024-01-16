import math
import os

import infra.basetest


class TestBc(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BC=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program executes.
        self.assertRunOk("bc --version")

        # We check a square root function of a number slightly larger
        # than 32 bits.
        value = 123456
        squared_value = value ** 2
        bc_expr = f"sqrt({squared_value})"
        cmd = f"echo '{bc_expr}' | bc"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), value)

        # Perform an integer exponentiation producing a large number.
        base = 3
        exponent = 4567
        expected_value = base ** exponent
        bc_expr = f"{base} ^ {exponent}"
        cmd = f"echo '{bc_expr}' | BC_LINE_LENGTH=0 bc"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), expected_value)

        # Test a basic output base conversion of a large number.
        hex_str = "DEADBEEF0000ABADC0DE00008BADF00D"
        hex_base = 16
        value = int(hex_str, base=hex_base)
        bc_expr = f"obase={hex_base} ; {value}"
        cmd = f"echo '{bc_expr}' | bc"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], hex_str)

        # Test a floating point computation by estimating Pi. Since we
        # use the bc arc-tangent a() function, we need the '-l'
        # option.
        bc_expr = "4 * a(1)"
        cmd = f"echo '{bc_expr}' | bc -l"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertAlmostEqual(float(output[0]), math.pi, places=16)
