################################################################################
#
# python-pypika-tortoise
#
################################################################################

PYTHON_PYPIKA_TORTOISE_VERSION = 0.6.5
PYTHON_PYPIKA_TORTOISE_SOURCE = pypika_tortoise-$(PYTHON_PYPIKA_TORTOISE_VERSION).tar.gz
PYTHON_PYPIKA_TORTOISE_SITE = https://files.pythonhosted.org/packages/c2/06/89fe5fff93c5a01dbdeb9f3d843a7e997dc6e3a87222a260a164ff91fb81
PYTHON_PYPIKA_TORTOISE_SETUP_TYPE = pep517
PYTHON_PYPIKA_TORTOISE_LICENSE = Apache-2.0
PYTHON_PYPIKA_TORTOISE_LICENSE_FILES = LICENSE
PYTHON_PYPIKA_TORTOISE_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
