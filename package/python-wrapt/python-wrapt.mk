################################################################################
#
# python-wrapt
#
################################################################################

PYTHON_WRAPT_VERSION = 1.17.3
PYTHON_WRAPT_SOURCE = wrapt-$(PYTHON_WRAPT_VERSION).tar.gz
PYTHON_WRAPT_SITE = https://files.pythonhosted.org/packages/95/8f/aeb76c5b46e273670962298c23e7ddde79916cb74db802131d49a85e4b7d
PYTHON_WRAPT_SETUP_TYPE = setuptools
PYTHON_WRAPT_LICENSE = BSD-2-Clause
PYTHON_WRAPT_LICENSE_FILES = LICENSE

$(eval $(python-package))
