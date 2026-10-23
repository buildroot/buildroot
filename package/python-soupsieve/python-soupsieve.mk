################################################################################
#
# python-soupsieve
#
################################################################################

PYTHON_SOUPSIEVE_VERSION = 3.0.4
PYTHON_SOUPSIEVE_SOURCE = soupsieve-$(PYTHON_SOUPSIEVE_VERSION).tar.gz
PYTHON_SOUPSIEVE_SITE = https://files.pythonhosted.org/packages/19/63/0b6bae54546aed98d72f12d09df57b19a287f01c84d22047fa2e23772ab9
PYTHON_SOUPSIEVE_SETUP_TYPE = hatch
PYTHON_SOUPSIEVE_LICENSE = MIT
PYTHON_SOUPSIEVE_LICENSE_FILES = LICENSE.md

$(eval $(python-package))
