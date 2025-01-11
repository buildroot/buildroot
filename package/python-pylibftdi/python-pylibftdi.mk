################################################################################
#
# python-pylibftdi
#
################################################################################

PYTHON_PYLIBFTDI_VERSION = 0.23.0
PYTHON_PYLIBFTDI_SOURCE = pylibftdi-$(PYTHON_PYLIBFTDI_VERSION).tar.gz
PYTHON_PYLIBFTDI_SITE = https://files.pythonhosted.org/packages/9d/f0/551ccbd8e989e898707e0e0859344fcf538c2310521847a1035ad3e9b164
PYTHON_PYLIBFTDI_LICENSE = MIT
PYTHON_PYLIBFTDI_LICENSE_FILES = LICENSE.txt
PYTHON_PYLIBFTDI_SETUP_TYPE = poetry
PYTHON_PYLIBFTDI_DEPENDENCIES = libftdi

$(eval $(python-package))
