################################################################################
#
# python-tomli-w
#
################################################################################

PYTHON_TOMLI_W_VERSION = 1.2.0
PYTHON_TOMLI_W_SOURCE = tomli_w-$(PYTHON_TOMLI_W_VERSION).tar.gz
PYTHON_TOMLI_W_SITE = https://files.pythonhosted.org/packages/19/75/241269d1da26b624c0d5e110e8149093c759b7a286138f4efd61a60e75fe
PYTHON_TOMLI_W_SETUP_TYPE = flit
PYTHON_TOMLI_W_LICENSE = MIT
PYTHON_TOMLI_W_LICENSE_FILES = LICENSE

$(eval $(python-package))
