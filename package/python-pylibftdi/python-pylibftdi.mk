################################################################################
#
# python-pylibftdi
#
################################################################################

PYTHON_PYLIBFTDI_VERSION = 0.24.2
PYTHON_PYLIBFTDI_SOURCE = pylibftdi-$(PYTHON_PYLIBFTDI_VERSION).tar.gz
PYTHON_PYLIBFTDI_SITE = https://files.pythonhosted.org/packages/26/d9/23e892c9a1d08a0e01623164cb84ee6334aa1c33dafd0f4cecf763513a31
PYTHON_PYLIBFTDI_LICENSE = MIT
PYTHON_PYLIBFTDI_LICENSE_FILES = LICENSE.txt
PYTHON_PYLIBFTDI_SETUP_TYPE = setuptools
PYTHON_PYLIBFTDI_DEPENDENCIES = libftdi

$(eval $(python-package))
