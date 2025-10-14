################################################################################
#
# python-validators
#
################################################################################

PYTHON_VALIDATORS_VERSION = 0.35.0
PYTHON_VALIDATORS_SOURCE = validators-$(PYTHON_VALIDATORS_VERSION).tar.gz
PYTHON_VALIDATORS_SITE = https://files.pythonhosted.org/packages/53/66/a435d9ae49850b2f071f7ebd8119dd4e84872b01630d6736761e6e7fd847
PYTHON_VALIDATORS_SETUP_TYPE = setuptools
PYTHON_VALIDATORS_LICENSE = MIT
PYTHON_VALIDATORS_LICENSE_FILES = LICENSE.txt
PYTHON_VALIDATORS_CPE_ID_VENDOR = validators_project
PYTHON_VALIDATORS_CPE_ID_PRODUCT = validators

$(eval $(python-package))
