################################################################################
#
# python-validators
#
################################################################################

PYTHON_VALIDATORS_VERSION = 0.20.0
PYTHON_VALIDATORS_SOURCE = validators-$(PYTHON_VALIDATORS_VERSION).tar.gz
PYTHON_VALIDATORS_SITE = https://files.pythonhosted.org/packages/95/14/ed0af6865d378cfc3c504aed0d278a890cbefb2f1934bf2dbe92ecf9d6b1
PYTHON_VALIDATORS_SETUP_TYPE = setuptools
PYTHON_VALIDATORS_LICENSE = MIT
PYTHON_VALIDATORS_LICENSE_FILES = LICENSE
PYTHON_VALIDATORS_CPE_ID_VENDOR = validators_project
PYTHON_VALIDATORS_CPE_ID_PRODUCT = validators

$(eval $(python-package))
