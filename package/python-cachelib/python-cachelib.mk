################################################################################
#
# python-cachelib
#
################################################################################

PYTHON_CACHELIB_VERSION = 0.17.0
PYTHON_CACHELIB_SOURCE = cachelib-$(PYTHON_CACHELIB_VERSION).tar.gz
PYTHON_CACHELIB_SITE = https://files.pythonhosted.org/packages/c6/f4/b20875916b83f68775093554ce2544b12255396ba69abd93d8903cce0feb
PYTHON_CACHELIB_SETUP_TYPE = flit
PYTHON_CACHELIB_LICENSE = BSD-3-Clause
PYTHON_CACHELIB_LICENSE_FILES = LICENSE.txt docs/license.rst

$(eval $(python-package))
