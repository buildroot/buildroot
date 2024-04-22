import os

import infra.basetest


class TestLrzsz(infra.basetest.BRTest):
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_PACKAGE_LRZSZ=y
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """

    def test_run(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

        fifo = "/tmp/return-fifo"
        data_fname = "data"
        data_path = f"/tmp/{data_fname}"

        # We check a program can execute.
        self.assertRunOk("sz --version")

        # We create a data file, to be transferred.
        cmd = f"dd if=/dev/urandom of={data_path} bs=1M count=1"
        self.assertRunOk(cmd)

        # We create a fifo, used as a return fifo.
        self.assertRunOk(f"mkfifo {fifo}")

        # We transfer the test data using ZMODEM over the pipe and our
        # return fifo.
        self.assertRunOk(f"sz {data_path} < {fifo} | rz > {fifo}")

        # The rz command is supposed to have created the received file
        # in the current directory. We expect the received data to be
        # the same as the original input file.
        self.assertRunOk(f"cmp {data_path} {data_fname}")
