from tests.package.test_compressor_base import TestCompressorBase


class TestLzip(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_LZIP=y
        """
    compress_cmd = "lzip"
    decompress_cmd = "lzip -d"
    compressed_file_ext = ".lz"
