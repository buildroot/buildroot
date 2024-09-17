################################################################################
#
# python-m2crypto
#
################################################################################

PYTHON_M2CRYPTO_VERSION = 0.42.0
PYTHON_M2CRYPTO_SOURCE = m2crypto-$(PYTHON_M2CRYPTO_VERSION).tar.gz
PYTHON_M2CRYPTO_SITE = https://files.pythonhosted.org/packages/85/9f/b8977ce2971cf5f823db3fdb31e7e061b9662da318a17b6bf0c653f84aee
PYTHON_M2CRYPTO_SETUP_TYPE = setuptools
PYTHON_M2CRYPTO_LICENSE = MIT
PYTHON_M2CRYPTO_LICENSE_FILES = LICENCE
PYTHON_M2CRYPTO_CPE_ID_VENDOR = m2crypto_project
PYTHON_M2CRYPTO_CPE_ID_PRODUCT = m2crypto
PYTHON_M2CRYPTO_DEPENDENCIES = openssl host-swig
PYTHON_M2CRYPTO_ENV = OPENSSL_PATH="$(STAGING_DIR)/usr"

$(eval $(python-package))
