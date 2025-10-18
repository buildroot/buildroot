import infra.basetest
import os


class TestHostPythonPyfatfs(infra.basetest.BRHostPkgTest):
    hostpkgs = ["host-python-pyfatfs",
                "host-genimage",
                "host-dosfstools",
                "host-mtools"]
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + infra.basetest.MINIMAL_CONFIG + \
        """
        BR2_PACKAGE_HOST_GENIMAGE=y
        BR2_PACKAGE_HOST_DOSFSTOOLS=y
        BR2_PACKAGE_HOST_MTOOLS=y
        """

    genimage_cfg = """
image test.vfat {
    vfat {
        files = {
            "test.txt"
        }
    }

    size = 8M
}"""

    def test_run(self):
        os.makedirs(os.path.join(self.builddir, "genimage-input"),
                    exist_ok=True)
        with open(os.path.join(self.builddir, "genimage-input", "test.txt"), "w") as f:
            f.write("Hello World!")
        with open(os.path.join(self.builddir, "genimage.cfg"), "w") as f:
            f.write(self.genimage_cfg)
        os.makedirs(os.path.join(self.builddir, "genimage-tmp"),
                    exist_ok=True)
        os.makedirs(os.path.join(self.builddir, "genimage-root"),
                    exist_ok=True)

        cmd = ["host/bin/genimage",
               "--config", os.path.join(self.builddir, "genimage.cfg"),
               "--outputpath", self.builddir,
               "--inputpath", os.path.join(self.builddir, "genimage-input"),
               "--tmppath", os.path.join(self.builddir, "genimage-tmp"),
               "--rootpath", os.path.join(self.builddir, "genimage-root"),
               "--mkdosfs", os.path.join(self.builddir, "host", "sbin", "mkdosfs"),
               "--mcopy", os.path.join(self.builddir, "host", "bin", "mcopy")
               ]
        infra.run_cmd_on_host(self.builddir, cmd)

        cmd = ["host/bin/python3", "-c",
               "import fs; fatfs = fs.open_fs('fat://test.vfat'); assert(fatfs.listdir('/') == ['TEST.TXT'])"]
        infra.run_cmd_on_host(self.builddir, cmd)
