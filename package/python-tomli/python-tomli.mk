################################################################################
#
# python-tomli
#
################################################################################

PYTHON_TOMLI_VERSION = 2.2.1
PYTHON_TOMLI_SOURCE = tomli-$(PYTHON_TOMLI_VERSION).tar.gz
PYTHON_TOMLI_SITE = https://files.pythonhosted.org/packages/18/87/302344fed471e44a87289cf4967697d07e532f2421fdaf868a303cbae4ff
PYTHON_TOMLI_LICENSE = MIT
PYTHON_TOMLI_LICENSE_FILES = LICENSE
PYTHON_TOMLI_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
