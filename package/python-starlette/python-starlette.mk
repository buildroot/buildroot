################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.41.0
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/78/53/c3a36690a923706e7ac841f649c64f5108889ab1ec44218dac45771f252a
PYTHON_STARLETTE_SETUP_TYPE = hatch
PYTHON_STARLETTE_LICENSE = BSD-3-Clause
PYTHON_STARLETTE_LICENSE_FILES = LICENSE.md
PYTHON_STARLETTE_CPE_ID_VENDOR = encode
PYTHON_STARLETTE_CPE_ID_PRODUCT = starlette

$(eval $(python-package))
