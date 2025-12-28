################################################################################
#
# python-pypika-tortoise
#
################################################################################

PYTHON_PYPIKA_TORTOISE_VERSION = 0.6.3
PYTHON_PYPIKA_TORTOISE_SOURCE = pypika_tortoise-$(PYTHON_PYPIKA_TORTOISE_VERSION).tar.gz
PYTHON_PYPIKA_TORTOISE_SITE = https://files.pythonhosted.org/packages/cc/28/86ec1bccb2609d20349def444ef9dfe84aeccc984caa62f4634d50fee164
PYTHON_PYPIKA_TORTOISE_SETUP_TYPE = pep517
PYTHON_PYPIKA_TORTOISE_LICENSE = Apache-2.0
PYTHON_PYPIKA_TORTOISE_LICENSE_FILES = LICENSE
PYTHON_PYPIKA_TORTOISE_DEPENDENCIES = host-python-pdm-backend

$(eval $(python-package))
