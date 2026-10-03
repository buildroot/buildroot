################################################################################
#
# python-pylibftdi
#
################################################################################

PYTHON_PYLIBFTDI_VERSION = 0.24.0
PYTHON_PYLIBFTDI_SOURCE = pylibftdi-$(PYTHON_PYLIBFTDI_VERSION).tar.gz
PYTHON_PYLIBFTDI_SITE = https://files.pythonhosted.org/packages/19/5f/f0e03128161fff27d4f92d57b7fab20fa64e9bcd53627442d2ef43b8882c
PYTHON_PYLIBFTDI_LICENSE = MIT
PYTHON_PYLIBFTDI_LICENSE_FILES = LICENSE.txt
PYTHON_PYLIBFTDI_SETUP_TYPE = setuptools
PYTHON_PYLIBFTDI_DEPENDENCIES = libftdi

$(eval $(python-package))
