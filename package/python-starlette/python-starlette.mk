################################################################################
#
# python-starlette
#
################################################################################

PYTHON_STARLETTE_VERSION = 0.27.0
PYTHON_STARLETTE_SOURCE = starlette-$(PYTHON_STARLETTE_VERSION).tar.gz
PYTHON_STARLETTE_SITE = https://files.pythonhosted.org/packages/06/68/559bed5484e746f1ab2ebbe22312f2c25ec62e4b534916d41a8c21147bf8
PYTHON_STARLETTE_SETUP_TYPE = pep517
PYTHON_STARLETTE_LICENSE = BSD-3-Clause
PYTHON_STARLETTE_LICENSE_FILES = LICENSE.md
PYTHON_STARLETTE_DEPENDENCIES = host-python-hatchling

$(eval $(python-package))
