################################################################################
#
# python-cachelib
#
################################################################################

PYTHON_CACHELIB_VERSION = 0.14.0
PYTHON_CACHELIB_SOURCE = cachelib-$(PYTHON_CACHELIB_VERSION).tar.gz
PYTHON_CACHELIB_SITE = https://files.pythonhosted.org/packages/66/a5/5eb041dbee71766704d44cf5dfb6950ab018be0fd02cd763ade09869e33c
PYTHON_CACHELIB_SETUP_TYPE = flit
PYTHON_CACHELIB_LICENSE = BSD-3-Clause
PYTHON_CACHELIB_LICENSE_FILES = LICENSE.txt docs/license.rst

$(eval $(python-package))
