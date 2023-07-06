from tests.package.test_compressor_base import TestCompressorBase


class TestXz(TestCompressorBase):
    __test__ = True
    config = TestCompressorBase.config + \
        """
        BR2_PACKAGE_XZ=y
        """
    compress_cmd = "xz"
