################################################################################
#
# python-tortoise-orm
#
################################################################################

PYTHON_TORTOISE_ORM_VERSION = 1.1.8
PYTHON_TORTOISE_ORM_SOURCE = tortoise_orm-$(PYTHON_TORTOISE_ORM_VERSION).tar.gz
PYTHON_TORTOISE_ORM_SITE = https://files.pythonhosted.org/packages/10/8c/059f284ed7a08e9cf3a45973e2b9d013a8f242fbb1051a06c3d60c638920
PYTHON_TORTOISE_ORM_SETUP_TYPE = pep517
PYTHON_TORTOISE_ORM_LICENSE = Apache-2.0
PYTHON_TORTOISE_ORM_LICENSE_FILES = LICENSE.txt
PYTHON_TORTOISE_ORM_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
