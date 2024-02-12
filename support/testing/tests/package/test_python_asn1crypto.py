from tests.package.test_python import TestPythonPackageBase


class TestPythonPy3Asn1Crypto(TestPythonPackageBase):
    __test__ = True
    config = TestPythonPackageBase.config + \
        """
        BR2_PACKAGE_CA_CERTIFICATES=y
        BR2_PACKAGE_PYTHON3=y
        BR2_PACKAGE_PYTHON_ASN1CRYPTO=y
        """
    sample_scripts = ["tests/package/sample_python_asn1crypto.py"]
    timeout = 40
