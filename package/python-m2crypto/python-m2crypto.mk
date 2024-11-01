################################################################################
#
# python-m2crypto
#
################################################################################

PYTHON_M2CRYPTO_VERSION = 0.43.0
PYTHON_M2CRYPTO_SOURCE = m2crypto-$(PYTHON_M2CRYPTO_VERSION).tar.gz
PYTHON_M2CRYPTO_SITE = https://files.pythonhosted.org/packages/ff/1b/4771f0ecfdd9df6752ae5d0cf040545bb3cfe8a504af87e05c9ac4a6a499
PYTHON_M2CRYPTO_SETUP_TYPE = setuptools
PYTHON_M2CRYPTO_LICENSE = MIT
PYTHON_M2CRYPTO_LICENSE_FILES = LICENCE
PYTHON_M2CRYPTO_CPE_ID_VENDOR = m2crypto_project
PYTHON_M2CRYPTO_CPE_ID_PRODUCT = m2crypto
PYTHON_M2CRYPTO_DEPENDENCIES = openssl host-swig
PYTHON_M2CRYPTO_ENV = OPENSSL_PATH="$(STAGING_DIR)/usr"

$(eval $(python-package))
