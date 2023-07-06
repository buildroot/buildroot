import os

import infra.basetest


class TestCompressorBase(infra.basetest.BRTest):
    """Common class to test a data compression/decompression package.

    Build an image containing the package enabled in config, start the
    emulator, login to it. It prepares a test data file with some
    redundancy to let compression program reduce the file size.

    Each test case that inherits from this class must have:
    __test__ = True  - to let nose2 know that it is a test case
    config           - defconfig fragment with the packages to run the test
    compress_cmd     - the compression program command (ex: "gzip")
                       it can also contain arguments (ex: "gzip -9")
    It also can have:
    decompress_cmd   - the decompression program (ex: "gunzip")
                       if unset, the default value is "un" appended with the
                       value of "compress_cmd".
    check_integrity_cmd
                     - the integrity check command (ex: "gzip -t")
                       in unset, the default value is "compress_cmd" appended
                       with " -t".
    compressed_file_ext
                     - the file extention of compressed files created by the
                       compress command. (ex: ".gz")
                       if unset, the default value is a dot "." appended with
                       the value of "compress_cmd".
    timeout          - timeout to the compression command. Some compression
                       program can take more time than the default value
                       (set to 5 seconds).
    """
    __test__ = False
    config = infra.basetest.BASIC_TOOLCHAIN_CONFIG + \
        """
        BR2_TARGET_ROOTFS_CPIO=y
        # BR2_TARGET_ROOTFS_TAR is not set
        """
    compress_cmd = "compressor-unknown"
    decompress_cmd = None
    check_integrity_cmd = None
    compressed_file_ext = None
    timeout = 5

    def __init__(self, names):
        """Setup common test variables."""
        super(TestCompressorBase, self).__init__(names)

        if self.decompress_cmd is None:
            self.decompress_cmd = "un" + self.compress_cmd

        if self.check_integrity_cmd is None:
            self.check_integrity_cmd = self.compress_cmd + " -t"

        if self.compressed_file_ext is None:
            self.compressed_file_ext = "." + self.compress_cmd

        self.ref_file = "reference.bin"
        self.test_file = "test.bin"
        self.comp_test_file = self.test_file + self.compressed_file_ext

    def login(self):
        cpio_file = os.path.join(self.builddir, "images", "rootfs.cpio")
        self.emulator.boot(arch="armv5",
                           kernel="builtin",
                           options=["-initrd", cpio_file])
        self.emulator.login()

    def test_run(self):
        self.login()
        self.prepare_data()
        self.compress_test()
        self.check_integrity_test()
        self.uncompress_test()
        self.compare_test()

    def prepare_data(self):
        # Create a data file composed of: 128kB of random data, then
        # 128kB of zeroes, then a repetition of the 1st 128kB of
        # random.
        self.assertRunOk("dd if=/dev/urandom of=rand.bin bs=128k count=1")
        self.assertRunOk("dd if=/dev/zero of=zeroes.bin bs=128k count=1")
        self.assertRunOk(f"cat rand.bin zeroes.bin rand.bin > {self.ref_file}")

        # Keep a copy of the reference data since
        # compressor/decompressor programs usually unlink source data
        # file.
        self.assertRunOk(f"cp {self.ref_file} {self.test_file}")

    def compress_test(self):
        # Run the compression
        self.assertRunOk(f"{self.compress_cmd} {self.test_file}", timeout=self.timeout)

        # Check that the compressed file was created with the expected name
        self.assertRunOk(f"test -e {self.comp_test_file}")

        # Remove the input test file. Some compressors (like gzip) are
        # removing it automatically by default. Some others (like lz4)
        # are keeping those by default. We always remove it to make
        # sure a new file will be recreated by the decompression.
        self.assertRunOk(f"rm -f {self.test_file}")

        # Check the compressed file is smaller than the input.
        # The "ls -l" command is for simplifying debugging
        self.assertRunOk(f"ls -l {self.ref_file} {self.comp_test_file}")
        ref_sz_cmd = f"wc -c < {self.ref_file}"
        comp_sz_cmd = f"wc -c < {self.comp_test_file}"
        self.assertRunOk(f"test $({ref_sz_cmd}) -gt $({comp_sz_cmd})")

    def check_integrity_test(self):
        # Check the compressed file integrity
        self.assertRunOk(f"{self.check_integrity_cmd} {self.comp_test_file}")

    def uncompress_test(self):
        # Run the decompression
        self.assertRunOk(f"{self.decompress_cmd} {self.comp_test_file}")

        # Check the decompressed file was created with the correct name
        self.assertRunOk(f"test -e {self.test_file}")

    def compare_test(self):
        # Check the decompressed file is exactly the same as the
        # reference created at the beginning
        self.assertRunOk(f"cmp {self.test_file} {self.ref_file}")
