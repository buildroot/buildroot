################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.10.1
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/10/ae/da295e3a85bf8188dd5f15e91e245ecc946c9c6af319883baaffd37f1b6d
PYTHON_APISPEC_SETUP_TYPE = flit
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
