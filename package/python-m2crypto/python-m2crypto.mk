################################################################################
#
# python-m2crypto
#
################################################################################

PYTHON_M2CRYPTO_VERSION = 0.40.1
PYTHON_M2CRYPTO_SOURCE = M2Crypto-$(PYTHON_M2CRYPTO_VERSION).tar.gz
PYTHON_M2CRYPTO_SITE = https://files.pythonhosted.org/packages/9e/a3/9433817493ea250db67a05de3361cb0a1d58531847d50406f2f28455e68c
PYTHON_M2CRYPTO_SETUP_TYPE = setuptools
PYTHON_M2CRYPTO_LICENSE = MIT
PYTHON_M2CRYPTO_LICENSE_FILES = LICENCE
PYTHON_M2CRYPTO_CPE_ID_VENDOR = m2crypto_project
PYTHON_M2CRYPTO_CPE_ID_PRODUCT = m2crypto
PYTHON_M2CRYPTO_DEPENDENCIES = openssl host-swig
PYTHON_M2CRYPTO_BUILD_OPTS = --openssl=$(STAGING_DIR)/usr

$(eval $(python-package))
