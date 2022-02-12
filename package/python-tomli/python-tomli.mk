################################################################################
#
# python-tomli
#
################################################################################

PYTHON_TOMLI_VERSION = 1.2.0
PYTHON_TOMLI_SOURCE = tomli-$(PYTHON_TOMLI_VERSION).tar.gz
PYTHON_TOMLI_SITE = https://files.pythonhosted.org/packages/ec/38/8eccdc662c61aed187d5f5b168c18b1d2de3827976c3691e4da8be7375aa
PYTHON_TOMLI_SETUP_TYPE = distutils
PYTHON_TOMLI_LICENSE = MIT
PYTHON_TOMLI_LICENSE_FILES = LICENSE

$(eval $(python-package))
$(eval $(host-python-package))
