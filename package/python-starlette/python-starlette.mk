################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 1.7.0
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/7b/2b/3850dc6bf7ef71b088962eba31dafc6cffd2f96e577ebb0bb316df96da3e
PYTHON_STARLETTE_SETUP_TYPE = hatch
PYTHON_STARLETTE_LICENSE = BSD-3-Clause
PYTHON_STARLETTE_LICENSE_FILES = LICENSE.md
PYTHON_STARLETTE_CPE_ID_VENDOR = encode
PYTHON_STARLETTE_CPE_ID_PRODUCT = starlette

$(eval $(python-package))
