################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.48.0
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/a7/a5/d6f429d43394057b67a6b5bbe6eae2f77a6bf7459d961fdb224bf206eee6
PYTHON_STARLETTE_SETUP_TYPE = hatch
PYTHON_STARLETTE_LICENSE = BSD-3-Clause
PYTHON_STARLETTE_LICENSE_FILES = LICENSE.md
PYTHON_STARLETTE_CPE_ID_VENDOR = encode
PYTHON_STARLETTE_CPE_ID_PRODUCT = starlette

$(eval $(python-package))
