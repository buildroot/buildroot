import os

import infra.basetest


class TestMicroPython(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        f"""
        BR2_PACKAGE_MICROPYTHON=y
        BR2_PACKAGE_MICROPYTHON_LIB=y
        BR2_ROOTFS_OVERLAY="{infra.filepath("tests/package/test_micropython/rootfs-overlay")}"
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def run_upy_code(self, python_code, opts=""):
        cmd = f'micropython {opts} -c "{python_code}"'
        output, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0, f"could not run '{cmd}', returned {ret}: '{output}'")
        return output

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # The micropython binary can execute.
        self.assertRunOk("micropython -h")

        # Query interpreter version and implementation.
        py_code = "import sys ; "
        py_code += "print('Version:', sys.version) ; "
        py_code += "print('Implementation:', sys.implementation)"
        self.run_upy_code(py_code)

        # Check implementation is 'micropython'.
        py_code = "import sys ; print(sys.implementation.name)"
        output = self.run_upy_code(py_code)
        self.assertEqual(output[0], "micropython")

        # Check micropython optimization are correctly reported.
        py_code = "import micropython ; print(micropython.opt_level())"
        for opt_level in range(4):
            output = self.run_upy_code(py_code, f"-O{opt_level}")
            self.assertEqual(
                int(output[0]),
                opt_level,
                f"Running '{py_code}' at -O{opt_level} returned '{output}'"
            )

        # Check micropython can return a non-zero exit code.
        expected_code = 123
        py_code = "import sys ; "
        py_code += f"sys.exit({expected_code})"
        cmd = f'micropython -c "{py_code}"'
        _, exit_code = self.emulator.run(cmd)
        self.assertEqual(exit_code, expected_code)

        # Check micropython computes correctly.
        input_value = 1234
        expected_output = str(sum(range(input_value)))
        py_code = f"print(sum(range(({input_value}))))"
        output = self.run_upy_code(py_code)
        self.assertEqual(output[0], expected_output)

        # Check a small script can execute.
        self.assertRunOk("/root/mandel.py", timeout=10)

        # Check we can use a micropython-lib module.
        msg = "Hello Buildroot!"
        filename = "file.txt"
        gz_filename = f"{filename}.gz"
        self.assertRunOk(f"echo '{msg}' > {filename}")
        self.assertRunOk(f"gzip {filename}")
        out, ret = self.emulator.run(f"/root/zcat.py {gz_filename}")
        self.assertEqual(ret, 0)
        self.assertEqual(out[0], msg)
