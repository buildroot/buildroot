################################################################################
#
# python-m2crypto
#
################################################################################

PYTHON_M2CRYPTO_VERSION = 0.38.0
PYTHON_M2CRYPTO_SOURCE = M2Crypto-$(PYTHON_M2CRYPTO_VERSION).tar.gz
PYTHON_M2CRYPTO_SITE = https://files.pythonhosted.org/packages/2c/52/c35ec79dd97a8ecf6b2bbd651df528abb47705def774a4a15b99977274e8
PYTHON_M2CRYPTO_SETUP_TYPE = setuptools
PYTHON_M2CRYPTO_LICENSE = MIT
PYTHON_M2CRYPTO_LICENSE_FILES = LICENCE
PYTHON_M2CRYPTO_CPE_ID_VENDOR = m2crypto_project
PYTHON_M2CRYPTO_CPE_ID_PRODUCT = m2crypto
PYTHON_M2CRYPTO_DEPENDENCIES = openssl host-swig
PYTHON_M2CRYPTO_BUILD_OPTS = --openssl=$(STAGING_DIR)/usr

# 0001-Mitigate-the-Bleichenbacher-timing-attacks-in-the-RSA-decryption-API-CVE-2020-25657.patch
PYTHON_M2CRYPTO_IGNORE_CVES += CVE-2020-25657

$(eval $(python-package))
