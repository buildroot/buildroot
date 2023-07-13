from tests.package.test_compressor_base import TestCompressorBase


class TestLz4(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_LZ4=y
        BR2_PACKAGE_LZ4_PROGS=y
        """
    compress_cmd = "lz4"
