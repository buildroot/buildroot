################################################################################
#
# python-cachelib
#
################################################################################

PYTHON_CACHELIB_VERSION = 0.13.0
PYTHON_CACHELIB_SOURCE = cachelib-$(PYTHON_CACHELIB_VERSION).tar.gz
PYTHON_CACHELIB_SITE = https://files.pythonhosted.org/packages/1d/69/0b5c1259e12fbcf5c2abe5934b5c0c1294ec0f845e2b4b2a51a91d79a4fb
PYTHON_CACHELIB_SETUP_TYPE = setuptools
PYTHON_CACHELIB_LICENSE = BSD-3-Clause
PYTHON_CACHELIB_LICENSE_FILES = LICENSE.rst docs/license.rst

$(eval $(python-package))
