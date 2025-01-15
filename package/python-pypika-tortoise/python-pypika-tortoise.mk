################################################################################
#
# python-pypika-tortoise
#
################################################################################

PYTHON_PYPIKA_TORTOISE_VERSION = 0.5.0
PYTHON_PYPIKA_TORTOISE_SOURCE = pypika_tortoise-$(PYTHON_PYPIKA_TORTOISE_VERSION).tar.gz
PYTHON_PYPIKA_TORTOISE_SITE = https://files.pythonhosted.org/packages/7d/7b/74dce3354d81988f1d69b689f20b28c3e92f2dcc0c46975bdafd3eb37b18
PYTHON_PYPIKA_TORTOISE_SETUP_TYPE = poetry
PYTHON_PYPIKA_TORTOISE_LICENSE = Apache-2.0
PYTHON_PYPIKA_TORTOISE_LICENSE_FILES = LICENSE

$(eval $(python-package))
