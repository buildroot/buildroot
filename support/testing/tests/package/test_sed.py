import os

import infra.basetest


class TestSed(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_SED=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def check_gnu_sed(self):
        in_file = "testfile.txt"

        # We create a test file for this test.
        self.assertRunOk(f"echo 'This is a test' > {in_file}")

        # Check we have the GNU sed by testing a GNU extension likely
        # not present in other implementation. See:
        # https://www.gnu.org/software/sed/manual/sed.html#Extended-Commands
        # Note: we cannot search for "GNU sed" in sed --version,
        # because busybox sed --version outputs: "This is not GNU sed
        # version 4.0". The 'F' and 'Q' sed commands are known to be
        # unimplemented in BusyBox 1.36.1.
        expected_code = 123
        sed_script = f"F;Q {expected_code}"
        cmd = f"sed '{sed_script}' {in_file}"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, expected_code)
        self.assertEqual(output, [in_file])

    def check_sed_substitute(self):
        testfile_num = 5

        # We create few different test files for this test.
        cmd = f'for i in $(seq {testfile_num}) ; do '
        cmd += 'echo "=== $i Hello ===" > file$i.txt ; '
        cmd += 'done'
        self.assertRunOk(cmd)

        # We reformat file content, in-place.
        sed_script = "s/^=== \\([0-9]*\\) \\(Hello\\) ===$/\\2 \\1/"
        cmd = f"sed -i '{sed_script}' file[0-9]*.txt"
        self.assertRunOk(cmd)

        # We substitute numbers with the string "Buildroot". We use an
        # extended regular expression (with the '+'), so we test with
        # the '-r' option.
        sed_script = "s/[0-9]+/Buildroot/g"
        cmd = f"sed -r -i '{sed_script}' file[0-9]*.txt"
        self.assertRunOk(cmd)

        # Our previous text manipulations are expected to end up with
        # the "Hello Buildroot" string in all files.
        cmd = "cat file[0-9]*.txt"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output, ["Hello Buildroot"] * testfile_num)

    def check_sed_line_count(self):
        # We use the '=' command to count lines.
        line_count = 1234
        cmd = f"seq {line_count} | sed -n '$='"
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(int(output[0]), line_count)

    def check_sed_line_address(self):
        input_file = "strings.txt"
        expected_file = "expected.txt"

        # We create simple data for this test.
        strings = ["one", "two", "three", "four", "five"]
        content = '\\n'.join(strings)
        cmd = f"echo -e \"{content}\" > {input_file}"
        self.assertRunOk(cmd)

        # The manipulation in this tests are expected to extract the
        # first and last of the input. We create the expected data for
        # comparison.
        expected_output = [strings[0], strings[-1]]
        content = '\\n'.join(expected_output)
        cmd = f"echo -e \"{content}\" > {expected_file}"
        self.assertRunOk(cmd)

        # We remove lines between strings "two" and "four" included.
        cmd = f"sed '/two/,/four/d' {input_file} > output1.txt"
        self.assertRunOk(cmd)

        # We check output is the same as the expected data.
        cmd = f"cmp {expected_file} output1.txt"
        self.assertRunOk(cmd)

        # We redo the same manipulation using line number addresses.
        cmd = f"sed -n '1p;5p' {input_file} > output2.txt"
        self.assertRunOk(cmd)

        # We check again output is correct.
        cmd = f"cmp {expected_file} output2.txt"
        self.assertRunOk(cmd)

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check the program can execute
        self.assertRunOk("sed --version")

        self.check_gnu_sed()
        self.check_sed_substitute()
        self.check_sed_line_count()
        self.check_sed_line_address()
