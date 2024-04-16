from tests.package.test_compressor_base import TestCompressorBase


class TestPixz(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_PIXZ=y
        """
    compress_cmd = "pixz -p3"
    decompress_cmd = "pixz -d"
    compressed_file_ext = ".xz"

    def check_integrity_test(self):
        # Do nothing for the integrity test because "pixz" does not
        # implement this feature. The "-t" option has other functions:
        # https://github.com/vasi/pixz/blob/v1.0.7/src/pixz.1.asciidoc#options
        pass
