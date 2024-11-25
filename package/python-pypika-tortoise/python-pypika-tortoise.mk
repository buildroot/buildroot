################################################################################
#
# python-pypika-tortoise
#
################################################################################

PYTHON_PYPIKA_TORTOISE_VERSION = 0.2.1
PYTHON_PYPIKA_TORTOISE_SOURCE = pypika_tortoise-$(PYTHON_PYPIKA_TORTOISE_VERSION).tar.gz
PYTHON_PYPIKA_TORTOISE_SITE = https://files.pythonhosted.org/packages/30/af/b4a6035611cf6f3990879385cf6d077013c1bdf7ea294d6ceebfa14c8d08
PYTHON_PYPIKA_TORTOISE_SETUP_TYPE = poetry
PYTHON_PYPIKA_TORTOISE_LICENSE = Apache-2.0
PYTHON_PYPIKA_TORTOISE_LICENSE_FILES = LICENSE

$(eval $(python-package))
