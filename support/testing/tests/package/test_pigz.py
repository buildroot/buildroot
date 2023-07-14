from tests.package.test_compressor_base import TestCompressorBase


class TestPigz(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_PIGZ=y
        """
    compress_cmd = "pigz -p3"
    decompress_cmd = "pigz -d -p3"
    compressed_file_ext = ".gz"
