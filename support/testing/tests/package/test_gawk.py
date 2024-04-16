import os

import infra.basetest


class TestGawk(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_GAWK=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def basic_gawk_tests(self):
        # Check the program can execute
        self.assertRunOk("gawk --version")

        # Check "awk" is "gawk": the Buildroot gawk package recipe is
        # supposed to install the symbolic link.
        output, exit_code = self.emulator.run("awk --version")
        self.assertEqual(exit_code, 0)
        self.assertTrue(output[0].startswith("GNU Awk"))

        # Check "gawk" can return a specific exit code
        code = 123
        cmd = "gawk 'BEGIN { exit(" + str(code) + "); }'"
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, code)

        # Run a basic print program
        test_string = "Hello Buildroot"
        cmd = "gawk 'BEGIN {print \"" + test_string + "\"; }'"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], test_string)

    def create_test_data(self):
        # Create some test data
        entries = ["one", "two", "three", "four"]
        for entry in entries:
            self.assertRunOk(f"echo {entry} >> data1.txt")

    def add_line_numbers(self):
        # Add line numbers with gawk
        cmd = "gawk '{ print NR \"\\t\" $1; }' data1.txt > data2.txt"
        self.assertRunOk(cmd)

    def sum_column(self):
        # Check the sum of the first column is 1+2+3+4 == 10
        awk_prg = "BEGIN { SUM = 0; } { SUM = SUM + $1; } END { print SUM; }"
        cmd = f"gawk '{awk_prg}' data2.txt"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), 10)

    def uppercase_column(self):
        # Extract only column 2 and convert it to upper case
        cmd = "gawk '{ print toupper($2); }' data2.txt > data3.txt"
        self.assertRunOk(cmd)

        # Prepare the same output using "data1.txt" and the "tr" command,
        # for verification
        cmd = "tr a-z A-Z < data1.txt > data3-tr.txt"
        self.assertRunOk(cmd)

        # "gawk" and "tr" output are expected to be the same
        self.assertRunOk("cmp data3.txt data3-tr.txt")

    def gawk_head(self):
        # Show the first 2 lines of a file
        cmd = "gawk 'NR <= 2 { print $0; }' data2.txt > data4.txt"
        self.assertRunOk(cmd)

        # Prepare the same output using the "head" command
        cmd = "head -2 data2.txt > data4-head.txt"
        self.assertRunOk(cmd)

        # "gawk" and "tr" output are expected to be the same
        self.assertRunOk("cmp data4.txt data4-head.txt")

    def gawk_specific(self):
        # Use PROCINFO, which is a gawk specific feature:
        # https://www.gnu.org/software/gawk/manual/gawk.html#POSIX_002fGNU
        awk_platform_prog = "BEGIN { print PROCINFO[\"platform\"]; }"
        cmd = f"gawk '{awk_platform_prog}'"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output[0], "posix")

        # Using the same gawk feature when running in POSIX mode should not
        # produce output.
        cmd = f"gawk --posix '{awk_platform_prog}'"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertTrue(len(output) == 1 and len(output[0]) == 0)

    def gawk_numeric(self):
        value = 1234
        squared_value = value * value
        cmd = "gawk 'BEGIN { print sqrt(" + str(squared_value) + "); }'"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), value)

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        self.basic_gawk_tests()
        self.create_test_data()
        self.add_line_numbers()
        self.sum_column()
        self.uppercase_column()
        self.gawk_head()
        self.gawk_specific()
        self.gawk_numeric()
