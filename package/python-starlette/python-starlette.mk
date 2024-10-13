################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.39.2
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/02/0a/62fbd5697f6174041f9b4e2e377b6f383f9189b77dbb7d73d24624caca1d
PYTHON_STARLETTE_SETUP_TYPE = pep517
PYTHON_STARLETTE_LICENSE = BSD-3-Clause
PYTHON_STARLETTE_LICENSE_FILES = LICENSE.md
PYTHON_STARLETTE_DEPENDENCIES = host-python-hatchling
PYTHON_STARLETTE_CPE_ID_VENDOR = encode
PYTHON_STARLETTE_CPE_ID_PRODUCT = starlette

$(eval $(python-package))
