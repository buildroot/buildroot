################################################################################
#
# python-tortoise-orm
#
################################################################################

PYTHON_TORTOISE_ORM_VERSION = 0.25.3
PYTHON_TORTOISE_ORM_SOURCE = tortoise_orm-$(PYTHON_TORTOISE_ORM_VERSION).tar.gz
PYTHON_TORTOISE_ORM_SITE = https://files.pythonhosted.org/packages/dd/be/0fdfcd8295f4f02a280f33bdda99c3edba450f9a212149232f2fbb6afa96
PYTHON_TORTOISE_ORM_SETUP_TYPE = pep517
PYTHON_TORTOISE_ORM_LICENSE = Apache-2.0
PYTHON_TORTOISE_ORM_LICENSE_FILES = LICENSE.txt
PYTHON_TORTOISE_ORM_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
