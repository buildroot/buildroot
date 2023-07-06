from tests.package.test_compressor_base import TestCompressorBase


class TestBzip2(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_BZIP2=y
        """
    compress_cmd = "bzip2"
    decompress_cmd = "bunzip2"
    compressed_file_ext = ".bz2"
