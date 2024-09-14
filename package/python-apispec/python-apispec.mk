################################################################################
#
# python-apispec
#
################################################################################

PYTHON_APISPEC_VERSION = 6.6.1
PYTHON_APISPEC_SOURCE = apispec-$(PYTHON_APISPEC_VERSION).tar.gz
PYTHON_APISPEC_SITE = https://files.pythonhosted.org/packages/ab/5b/5d94e1ec6a8e487c026b2a7518dfb7ea90c4c82db48de33c227b7c9141fb
PYTHON_APISPEC_SETUP_TYPE = flit
PYTHON_APISPEC_LICENSE = MIT
PYTHON_APISPEC_LICENSE_FILES = LICENSE

$(eval $(python-package))
