################################################################################
#
# python-validators
#
################################################################################

PYTHON_VALIDATORS_VERSION = 0.36.0
PYTHON_VALIDATORS_SOURCE = validators-$(PYTHON_VALIDATORS_VERSION).tar.gz
PYTHON_VALIDATORS_SITE = https://files.pythonhosted.org/packages/7b/3f/4fe7905f73ba0e768baa102a09ba9458f2f0bb4a676102e1fd7a3cb55c2b
PYTHON_VALIDATORS_SETUP_TYPE = setuptools
PYTHON_VALIDATORS_LICENSE = MIT
PYTHON_VALIDATORS_LICENSE_FILES = LICENSE.txt
PYTHON_VALIDATORS_CPE_ID_VENDOR = validators_project
PYTHON_VALIDATORS_CPE_ID_PRODUCT = validators

$(eval $(python-package))
