################################################################################
#
# python-tortoise-orm
#
################################################################################

PYTHON_TORTOISE_ORM_VERSION = 0.20.0
PYTHON_TORTOISE_ORM_SOURCE = tortoise_orm-$(PYTHON_TORTOISE_ORM_VERSION).tar.gz
PYTHON_TORTOISE_ORM_SITE = https://files.pythonhosted.org/packages/3b/84/8ca142fe370d59c4e3135825b2822d199c4f885ae855657c1a7361e68511
PYTHON_TORTOISE_ORM_SETUP_TYPE = pep517
PYTHON_TORTOISE_ORM_LICENSE = Apache-2.0
PYTHON_TORTOISE_ORM_LICENSE_FILES = LICENSE.txt
PYTHON_TORTOISE_ORM_DEPENDENCIES = host-python-poetry-core

$(eval $(python-package))
