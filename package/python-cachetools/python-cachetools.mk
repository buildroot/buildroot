################################################################################
#
# python-cachetools
#
################################################################################

PYTHON_CACHETOOLS_VERSION = 7.2.1
PYTHON_CACHETOOLS_SOURCE = cachetools-$(PYTHON_CACHETOOLS_VERSION).tar.gz
PYTHON_CACHETOOLS_SITE = https://files.pythonhosted.org/packages/31/44/71476a5812da1ddf2c9a3efd31ae76d01480a1cf03ed13ac28aa8f2402e4
PYTHON_CACHETOOLS_SETUP_TYPE = setuptools
PYTHON_CACHETOOLS_LICENSE = MIT
PYTHON_CACHETOOLS_LICENSE_FILES = LICENSE
PYTHON_CACHETOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
