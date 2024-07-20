import os

import infra.basetest


class TestMawk(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_MAWK=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def basic_mawk_tests(self):
        # Check the program can execute
        self.assertRunOk("mawk --version")

        # Check "mawk" can return a specific exit code
        code = 123
        cmd = "mawk 'BEGIN { exit(" + str(code) + "); }'"
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, code)

        # Run a basic print program
        test_string = "Hello Buildroot"
        cmd = "mawk 'BEGIN {print \"" + test_string + "\"; }'"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], test_string)

    def create_test_data(self):
        # Create some test data
        entries = ["one", "two", "three", "four"]
        for entry in entries:
            self.assertRunOk(f"echo {entry} >> data1.txt")

    def add_line_numbers(self):
        # Add line numbers with mawk
        cmd = "mawk '{ print NR \"\\t\" $1; }' data1.txt > data2.txt"
        self.assertRunOk(cmd)

    def sum_column(self):
        # Check the sum of the first column is 1+2+3+4 == 10
        awk_prg = "BEGIN { SUM = 0; } { SUM = SUM + $1; } END { print SUM; }"
        cmd = f"mawk '{awk_prg}' data2.txt"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), 10)

    def uppercase_column(self):
        # Extract only column 2 and convert it to upper case
        cmd = "mawk '{ print toupper($2); }' data2.txt > data3.txt"
        self.assertRunOk(cmd)

        # Prepare the same output using "data1.txt" and the "tr" command,
        # for verification
        cmd = "tr a-z A-Z < data1.txt > data3-tr.txt"
        self.assertRunOk(cmd)

        # "mawk" and "tr" output are expected to be the same
        self.assertRunOk("cmp data3.txt data3-tr.txt")

    def mawk_head(self):
        # Show the first 2 lines of a file
        cmd = "mawk 'NR <= 2 { print $0; }' data2.txt > data4.txt"
        self.assertRunOk(cmd)

        # Prepare the same output using the "head" command
        cmd = "head -2 data2.txt > data4-head.txt"
        self.assertRunOk(cmd)

        # "mawk" and "tr" output are expected to be the same
        self.assertRunOk("cmp data4.txt data4-head.txt")

    def mawk_specific(self):
        # Use the "-W dump" mawk specific option.
        # See: https://invisible-island.net/mawk/manpage/mawk.html
        # We create an arbitrary awk program with an integer and
        # string constant. We then check those constants are in the
        # mawk "assembler" output.
        awk_int = 12345
        awk_str = "Buildroot"
        awk_expr = f"print ($1 + {awk_int}) \"{awk_str}\";"
        awk_prg = "BEGIN { " + awk_expr + " }"
        cmd = f"mawk -W dump '{awk_prg}'"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        out_str = "\n".join(output)
        self.assertIn(str(awk_int), out_str)
        self.assertIn(awk_str, out_str)

    def mawk_numeric(self):
        value = 1234
        squared_value = value * value
        cmd = "mawk 'BEGIN { print sqrt(" + str(squared_value) + "); }'"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), value)

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.basic_mawk_tests()
        self.create_test_data()
        self.add_line_numbers()
        self.sum_column()
        self.uppercase_column()
        self.mawk_head()
        self.mawk_specific()
        self.mawk_numeric()
