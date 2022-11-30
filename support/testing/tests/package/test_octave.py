import os

import infra.basetest


class TestOctave(infra.basetest.BRTest):
    # infra.basetest.BASIC_TOOLCHAIN_CONFIG cannot be used as it does
    # not include gfortran.
    config = \
        """
        BR2_aarch64=y
        BR2_TOOLCHAIN_EXTERNAL=y
        BR2_TARGET_GENERIC_GETTY_PORT="ttyAMA0"
        BR2_LINUX_KERNEL=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION=y
        BR2_LINUX_KERNEL_CUSTOM_VERSION_VALUE="5.15.26"
        BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG=y
        BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE="board/qemu/aarch64-virt/linux.config"
        BR2_LINUX_KERNEL_NEEDS_HOST_OPENSSL=y
        BR2_TARGET_ROOTFS_CPIO=y
        BR2_TARGET_ROOTFS_CPIO_GZIP=y
        # BR2_TARGET_ROOTFS_TAR is not set
        BR2_PACKAGE_OCTAVE=y
        """
    timeout = 60

    def octave_cmd(self, octave_expr):
        return "octave --quiet --eval '{}'".format(octave_expr)

    def test_run(self):
        img = os.path.join(self.builddir, "images", "rootfs.cpio.gz")
        kern = os.path.join(self.builddir, "images", "Image")
        self.emulator.boot(arch="aarch64",
                           kernel=kern,
                           kernel_cmdline=["console=ttyAMA0"],
                           options=["-M", "virt", "-cpu", "cortex-a57", "-m", "512M", "-initrd", img])
        self.emulator.login()

        # Check Euler identity
        cmd = self.octave_cmd("assert (exp(i*pi)+1, 0, 1e-10)")
        self.assertRunOk(cmd)

        # Solve equation system example from Octave homepage
        octave_expr = "b = [4; 9; 2]; "
        octave_expr += "A = [ 3 4 5; 1 3 1; 3 5 9 ]; "
        octave_expr += "x = A \\ b; "
        octave_expr += "assert(x, [-1.5; 4; -1.5], 1e-10)"
        cmd = self.octave_cmd(octave_expr)
        self.assertRunOk(cmd)

        # Check octave can fail
        cmd = self.octave_cmd("assert(false)")
        _, exit_code = self.emulator.run(cmd)
        self.assertNotEqual(exit_code, 0)

        # Check string output
        string = "Hello World"
        cmd = self.octave_cmd("printf(\"{}\\n\")".format(string))
        output, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, 0)
        self.assertEqual(output, [string])

        # Run some octave self tests
        octave_modules = [
            "elfun/atan2d",
            "elfun/sind",
            "general/gradient",
            "general/num2str",
            "polynomial/poly",
            "signal/fftconv",
            "special-matrix/magic",
            "specfun/isprime",
            "statistics/corr",
            "strings/str2num"
        ]

        for mod in octave_modules:
            cmd = self.octave_cmd('assert(test(\"{}\"),true)'.format(mod))
            self.assertRunOk(cmd, timeout=10)
