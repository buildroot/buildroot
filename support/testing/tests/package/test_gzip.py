from tests.package.test_compressor_base import TestCompressorBase


class TestGzip(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_BUSYBOX_SHOW_OTHERS=y
        BR2_PACKAGE_GZIP=y
        """
    compress_cmd = "gzip"
    decompress_cmd = "gunzip"
    compressed_file_ext = ".gz"
