################################################################################
#
# python-pypika-tortoise
#
################################################################################

PYTHON_PYPIKA_TORTOISE_VERSION = 0.6.2
PYTHON_PYPIKA_TORTOISE_SOURCE = pypika_tortoise-$(PYTHON_PYPIKA_TORTOISE_VERSION).tar.gz
PYTHON_PYPIKA_TORTOISE_SITE = https://files.pythonhosted.org/packages/1a/7b/0a31165e22e599ba149ba35d4323d343205a70d91a4f6e8c6565f5b4fa08
PYTHON_PYPIKA_TORTOISE_SETUP_TYPE = pep517
PYTHON_PYPIKA_TORTOISE_LICENSE = Apache-2.0
PYTHON_PYPIKA_TORTOISE_LICENSE_FILES = LICENSE
PYTHON_PYPIKA_TORTOISE_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
