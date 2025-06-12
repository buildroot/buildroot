################################################################################
#
# python-tortoise-orm
#
################################################################################

PYTHON_TORTOISE_ORM_VERSION = 0.25.0
PYTHON_TORTOISE_ORM_SOURCE = tortoise_orm-$(PYTHON_TORTOISE_ORM_VERSION).tar.gz
PYTHON_TORTOISE_ORM_SITE = https://files.pythonhosted.org/packages/d8/02/89777797d2c74386e21fca4a879d15eef6a0a789e4b9564355e94c367e6e
PYTHON_TORTOISE_ORM_SETUP_TYPE = poetry
PYTHON_TORTOISE_ORM_LICENSE = Apache-2.0
PYTHON_TORTOISE_ORM_LICENSE_FILES = LICENSE.txt

$(eval $(python-package))
