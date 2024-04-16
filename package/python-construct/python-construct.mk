################################################################################
#
# python-construct
#
################################################################################

PYTHON_CONSTRUCT_VERSION = 2.10.70
PYTHON_CONSTRUCT_SOURCE = construct-$(PYTHON_CONSTRUCT_VERSION).tar.gz
PYTHON_CONSTRUCT_SITE = https://files.pythonhosted.org/packages/02/77/8c84b98eca70d245a2a956452f21d57930d22ab88cbeed9290ca630cf03f
PYTHON_CONSTRUCT_SETUP_TYPE = setuptools
PYTHON_CONSTRUCT_LICENSE = MIT
PYTHON_CONSTRUCT_LICENSE_FILES = LICENSE

$(eval $(python-package))
