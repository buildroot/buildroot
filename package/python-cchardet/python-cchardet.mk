################################################################################
#
# python-cchardet
#
################################################################################

PYTHON_CCHARDET_VERSION = 2.3.0
PYTHON_CCHARDET_SOURCE = cchardet-$(PYTHON_CCHARDET_VERSION).tar.gz
PYTHON_CCHARDET_SITE = https://files.pythonhosted.org/packages/86/80/6b87429533a8a6fc5b970c44a3a844c315c3313377ecc4fb9efeb56a3241
PYTHON_CCHARDET_SETUP_TYPE = setuptools
PYTHON_CCHARDET_LICENSE = MPL-1.1
PYTHON_CCHARDET_LICENSE_FILES = COPYING
PYTHON_CCHARDET_DEPENDENCIES = host-python-cython

$(eval $(python-package))
