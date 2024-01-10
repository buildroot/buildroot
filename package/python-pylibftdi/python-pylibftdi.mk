################################################################################
#
# python-pylibftdi
#
################################################################################

PYTHON_PYLIBFTDI_VERSION = 0.21.0
PYTHON_PYLIBFTDI_SOURCE = pylibftdi-$(PYTHON_PYLIBFTDI_VERSION).tar.gz
PYTHON_PYLIBFTDI_SITE = https://files.pythonhosted.org/packages/d2/ce/ff3e83f3a14eb5b7950ff3657f07cdc3033dd0ded5c8ed093db515e1de33
PYTHON_PYLIBFTDI_LICENSE = MIT
PYTHON_PYLIBFTDI_LICENSE_FILES = LICENSE.txt
PYTHON_PYLIBFTDI_DEPENDENCIES = libftdi
PYTHON_PYLIBFTDI_SETUP_TYPE = setuptools

$(eval $(python-package))
