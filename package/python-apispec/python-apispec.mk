################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.9.0
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/02/ad/30cd449f3a0cf213dd13d9af7ba869214d8c66d517939964d3f490307e46
PYTHON_APISPEC_SETUP_TYPE = flit
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
