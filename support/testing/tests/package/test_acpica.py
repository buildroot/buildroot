import os

import infra.basetest


class TestAcpica(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_ACPICA=y
        BR2_ROOTFS_OVERLAY="{}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """.format(
           # overlay to add an ASL source file
           infra.filepath("tests/package/test_acpica/rootfs-overlay"))

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # Check a program can execute
        self.assertRunOk("iasl -v")

        # Check "acpiexamples" demo is running
        self.assertRunOk("acpiexamples")

        # Check "acpihelp" convert error code 0x1 to AE_ERROR
        self.assertRunOk("acpihelp -e 1 | grep -F AE_ERROR")

        # Check "acpihelp" convert 0xA3 opcode to NoOpOp
        self.assertRunOk("acpihelp -o 0xA3 | grep -F NoOpOp")

        # Compile a simple ASL file
        # The output file is automatically set to "dsdt.aml"
        self.assertRunOk("iasl dsdt.asl")

        # Evaluate the AML with acpiexec
        # STR0 is expected to be "Hello Buildroot!"
        cmd = "acpiexec -b 'evaluate STR0' dsdt.aml"
        cmd += " | grep -F '\"Hello Buildroot!\"'"
        self.assertRunOk(cmd)

        # INT1 is exepcted to be 12345678
        cmd = "acpiexec -b 'evaluate INT1' dsdt.aml"
        cmd += " | grep -F 12345678"
        self.assertRunOk(cmd)

        # Evalute the TEST method which prints its argument
        cmd = "acpiexec -b 'evaluate TST2 \"Hello World\"' dsdt.aml"
        cmd += " | grep -F 'Arg0=Hello World'"
        self.assertRunOk(cmd)

        # dump aml to text
        self.assertRunOk("acpidump -f dsdt.aml -o dsdt.dump")

        # Rebuild dump to binary with acpixtract
        # Output is implicitly into the dsdt.dat file
        self.assertRunOk("acpixtract -a dsdt.dump")

        # Compare with acpibin
        # The rebuilt dsdt.dat is expected to be the same
        cmd = "acpibin -a dsdt.aml dsdt.dat"
        cmd += " | grep -F 'Files compare exactly'"
        self.assertRunOk(cmd)

        # Compare with cmp, to check acpibin
        self.assertRunOk("cmp dsdt.aml dsdt.dat")

        # Disassemble the compiled ASL
        # Output file is implicitly "dsdt.dsl", we rename it to
        # "disa.dsl" to make sure it will not clash with the original
        # file, when recompiling.
        self.assertRunOk("iasl dsdt.aml && mv -v dsdt.dsl disa.dsl")

        # Disassembled output should contain our string
        self.assertRunOk("grep STR0 disa.dsl | grep '\"Hello Buildroot!\"'")

        # Recompile the disassembled file
        self.assertRunOk("iasl disa.dsl")

        # Compare the first compiled file with the one recompiled from
        # the disassembly. There are expected to be identical.
        cmd = "acpibin -a dsdt.aml disa.aml"
        cmd += " | grep -F 'Files compare exactly'"
        self.assertRunOk(cmd)

        # Also compare with "cmp"
        self.assertRunOk("cmp dsdt.aml disa.aml")
