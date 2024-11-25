################################################################################
#
# python-pylibftdi
#
################################################################################

PYTHON_PYLIBFTDI_VERSION = 0.22.0
PYTHON_PYLIBFTDI_SOURCE = pylibftdi-$(PYTHON_PYLIBFTDI_VERSION).tar.gz
PYTHON_PYLIBFTDI_SITE = https://files.pythonhosted.org/packages/74/b3/a3c333a250143d204a0bb60de7c1e5f841543231f04c71ff4fa65e5b90c2
PYTHON_PYLIBFTDI_LICENSE = MIT
PYTHON_PYLIBFTDI_LICENSE_FILES = LICENSE.txt
PYTHON_PYLIBFTDI_SETUP_TYPE = poetry
PYTHON_PYLIBFTDI_DEPENDENCIES = libftdi

$(eval $(python-package))
