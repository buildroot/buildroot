from tests.package.test_compressor_base import TestCompressorBase


class TestLzop(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_LZOP=y
        """
    compress_cmd = "lzop"
    decompress_cmd = "lzop -d"
    compressed_file_ext = ".lzo"
