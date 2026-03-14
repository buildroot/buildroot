################################################################################
#
# python-tortoise-orm
#
################################################################################

PYTHON_TORTOISE_ORM_VERSION = 1.1.6
PYTHON_TORTOISE_ORM_SOURCE = tortoise_orm-$(PYTHON_TORTOISE_ORM_VERSION).tar.gz
PYTHON_TORTOISE_ORM_SITE = https://files.pythonhosted.org/packages/40/76/629a5d69c170605dbdc10f3f3416d124fae05836860686ccd9e06726810c
PYTHON_TORTOISE_ORM_SETUP_TYPE = pep517
PYTHON_TORTOISE_ORM_LICENSE = Apache-2.0
PYTHON_TORTOISE_ORM_LICENSE_FILES = LICENSE.txt
PYTHON_TORTOISE_ORM_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
