################################################################################
#
# python-tortoise-orm
#
################################################################################

PYTHON_TORTOISE_ORM_VERSION = 0.23.0
PYTHON_TORTOISE_ORM_SOURCE = tortoise_orm-$(PYTHON_TORTOISE_ORM_VERSION).tar.gz
PYTHON_TORTOISE_ORM_SITE = https://files.pythonhosted.org/packages/1b/6e/c23d788524750d84c75864eac0176f57c07a5316b36cc467d2914a109bef
PYTHON_TORTOISE_ORM_SETUP_TYPE = poetry
PYTHON_TORTOISE_ORM_LICENSE = Apache-2.0
PYTHON_TORTOISE_ORM_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
