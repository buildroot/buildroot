################################################################################
#
# python-tomli
#
################################################################################

PYTHON_TOMLI_VERSION = 2.0.2
PYTHON_TOMLI_SOURCE = tomli-$(PYTHON_TOMLI_VERSION).tar.gz
PYTHON_TOMLI_SITE = https://files.pythonhosted.org/packages/35/b9/de2a5c0144d7d75a57ff355c0c24054f965b2dc3036456ae03a51ea6264b
PYTHON_TOMLI_LICENSE = MIT
PYTHON_TOMLI_LICENSE_FILES = LICENSE
PYTHON_TOMLI_SETUP_TYPE = flit

$(eval $(python-package))
$(eval $(host-python-package))
