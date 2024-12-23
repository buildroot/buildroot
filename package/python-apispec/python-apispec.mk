################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.8.0
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/12/66/81f6f31feafb0ee2f6c649ba33f4c768f837bbabef279f12053d00a7099d
PYTHON_APISPEC_SETUP_TYPE = flit
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
