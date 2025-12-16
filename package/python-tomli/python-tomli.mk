################################################################################
#
# python-tomli
#
################################################################################

PYTHON_TOMLI_VERSION = 2.3.0
PYTHON_TOMLI_SOURCE = tomli-$(PYTHON_TOMLI_VERSION).tar.gz
PYTHON_TOMLI_SITE = https://files.pythonhosted.org/packages/52/ed/3f73f72945444548f33eba9a87fc7a6e969915e7b1acc8260b30e1f76a2f
PYTHON_TOMLI_LICENSE = MIT
PYTHON_TOMLI_LICENSE_FILES = LICENSE
PYTHON_TOMLI_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
