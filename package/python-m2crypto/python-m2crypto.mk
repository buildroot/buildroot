################################################################################
#
# python-m2crypto
#
################################################################################

PYTHON_M2CRYPTO_VERSION = 0.37.1
PYTHON_M2CRYPTO_SOURCE = M2Crypto-$(PYTHON_M2CRYPTO_VERSION).tar.gz
PYTHON_M2CRYPTO_SITE = https://files.pythonhosted.org/packages/aa/36/9fef97358e378c1d3bd567c4e8f8ca0428a8d7e869852cef445ee6da91fd
PYTHON_M2CRYPTO_SETUP_TYPE = setuptools
PYTHON_M2CRYPTO_LICENSE = MIT
PYTHON_M2CRYPTO_LICENSE_FILES = LICENCE
PYTHON_M2CRYPTO_CPE_ID_VENDOR = m2crypto_project
PYTHON_M2CRYPTO_CPE_ID_PRODUCT = m2crypto
PYTHON_M2CRYPTO_DEPENDENCIES = openssl host-swig
PYTHON_M2CRYPTO_BUILD_OPTS = --openssl=$(STAGING_DIR)/usr

$(eval $(python-package))
