from tests.package.test_compressor_base import TestCompressorBase


class TestBrotli(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_BROTLI=y
        """
    compress_cmd = "brotli"
    decompress_cmd = "brotli -d"
    compressed_file_ext = ".br"
    timeout = 60
