################################################################################
#
# python-cachetools
#
################################################################################

PYTHON_CACHETOOLS_VERSION = 7.2.8
PYTHON_CACHETOOLS_SOURCE = cachetools-$(PYTHON_CACHETOOLS_VERSION).tar.gz
PYTHON_CACHETOOLS_SITE = https://files.pythonhosted.org/packages/93/6f/faa5e0606769105e70e0478031a8f9a6b729e329f42ce2462585c6d9aa52
PYTHON_CACHETOOLS_SETUP_TYPE = setuptools
PYTHON_CACHETOOLS_LICENSE = MIT
PYTHON_CACHETOOLS_LICENSE_FILES = LICENSE
PYTHON_CACHETOOLS_DEPENDENCIES = host-python-setuptools-scm

$(eval $(python-package))
