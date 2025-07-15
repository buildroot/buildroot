################################################################################
#
# python-pypika-tortoise
#
################################################################################

PYTHON_PYPIKA_TORTOISE_VERSION = 0.6.1
PYTHON_PYPIKA_TORTOISE_SOURCE = pypika_tortoise-$(PYTHON_PYPIKA_TORTOISE_VERSION).tar.gz
PYTHON_PYPIKA_TORTOISE_SITE = https://files.pythonhosted.org/packages/db/03/c293fd42c3669e5a79d508c3ed1ca3ffa501600d93abd904a0f86d493ba0
PYTHON_PYPIKA_TORTOISE_SETUP_TYPE = poetry
PYTHON_PYPIKA_TORTOISE_LICENSE = Apache-2.0
PYTHON_PYPIKA_TORTOISE_LICENSE_FILES = LICENSE

$(eval $(python-package))
