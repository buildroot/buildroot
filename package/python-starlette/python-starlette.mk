################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.47.2
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/04/57/d062573f391d062710d4088fa1369428c38d51460ab6fedff920efef932e
PYTHON_STARLETTE_SETUP_TYPE = hatch
PYTHON_STARLETTE_LICENSE = BSD-3-Clause
PYTHON_STARLETTE_LICENSE_FILES = LICENSE.md
PYTHON_STARLETTE_CPE_ID_VENDOR = encode
PYTHON_STARLETTE_CPE_ID_PRODUCT = starlette

$(eval $(python-package))
