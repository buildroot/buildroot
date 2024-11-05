################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.7.1
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/96/26/ef0e72400707469058a7536f64d4e00e1a1c07a179acd00fb7e424dc9330
PYTHON_APISPEC_SETUP_TYPE = flit
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
