################################################################################
#
# python-validators
#
################################################################################

PYTHON_VALIDATORS_VERSION = 0.22.0
PYTHON_VALIDATORS_SOURCE = validators-$(PYTHON_VALIDATORS_VERSION).tar.gz
PYTHON_VALIDATORS_SITE = https://files.pythonhosted.org/packages/9b/21/40a249498eee5a244a017582c06c0af01851179e2617928063a3d628bc8f
PYTHON_VALIDATORS_SETUP_TYPE = setuptools
PYTHON_VALIDATORS_LICENSE = MIT
PYTHON_VALIDATORS_LICENSE_FILES = LICENSE
PYTHON_VALIDATORS_CPE_ID_VENDOR = validators_project
PYTHON_VALIDATORS_CPE_ID_PRODUCT = validators

$(eval $(python-package))
