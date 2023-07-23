from tests.package.test_compressor_base import TestCompressorBase


class TestLrzip(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_LRZIP=y
        """
    compress_cmd = "lrzip"
    decompress_cmd = "lrunzip"
    compressed_file_ext = ".lrz"
