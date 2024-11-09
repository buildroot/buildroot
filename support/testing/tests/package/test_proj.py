import os

import infra.basetest


class TestProj(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_PROJ=y
        BR2_PACKAGE_PROJ_APPS=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        # We check the program can run. The "proj" command does not
        # have a "--version" option. It will just show its version
        # when invoked without any argument.
        self.assertRunOk("proj")

        # The commands in this tests are taken from the Proj
        # documentation quickstart page, at:
        # https://proj.org/en/9.5/usage/quickstart.html

        proj_str = "+proj=merc +lat_ts=56.5 +ellps=GRS80"
        cmd = "echo 55.2 12.2"
        cmd += f" | proj {proj_str}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected_values = [3399483.80, 752085.60]
        values = list(map(lambda x: float(x), out[0].split()))
        for i in range(len(expected_values)):
            self.assertAlmostEqual(values[i], expected_values[i])

        proj_str = "+proj=merc +lat_ts=56.5 +ellps=GRS80 +to +proj=utm +zone=32"
        cmd = "echo 3399483.80 752085.60"
        cmd += f" | cs2cs {proj_str}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected_values = [6103992.36, 1924052.47, 0.00]
        values = list(map(lambda x: float(x), out[0].split()))
        for i in range(len(expected_values)):
            self.assertAlmostEqual(values[i], expected_values[i])

        proj_str = "+init=epsg:4326 +to +init=epsg:25832"
        cmd = "echo 56 12"
        cmd += f" | cs2cs {proj_str}"
        out, ret = self.emulator.run(cmd)
        self.assertEqual(ret, 0)
        expected_values = [6231950.54, 1920310.71, 0.00]
        values = list(map(lambda x: float(x), out[0].split()))
        for i in range(len(expected_values)):
            self.assertAlmostEqual(values[i], expected_values[i])
