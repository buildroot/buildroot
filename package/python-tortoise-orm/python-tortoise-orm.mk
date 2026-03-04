################################################################################
#
# python-tortoise-orm
#
################################################################################

PYTHON_TORTOISE_ORM_VERSION = 1.1.5
PYTHON_TORTOISE_ORM_SOURCE = tortoise_orm-$(PYTHON_TORTOISE_ORM_VERSION).tar.gz
PYTHON_TORTOISE_ORM_SITE = https://files.pythonhosted.org/packages/f3/b0/2b3962847aad793d32646c6e43e7fab6f845f34a5502da5722fe704ec847
PYTHON_TORTOISE_ORM_SETUP_TYPE = pep517
PYTHON_TORTOISE_ORM_LICENSE = Apache-2.0
PYTHON_TORTOISE_ORM_LICENSE_FILES = LICENSE.txt
PYTHON_TORTOISE_ORM_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
