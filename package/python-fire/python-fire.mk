################################################################################
#
# python-fire
#
################################################################################

PYTHON_FIRE_VERSION = 0.7.0
PYTHON_FIRE_SOURCE = fire-$(PYTHON_FIRE_VERSION).tar.gz
PYTHON_FIRE_SITE = https://files.pythonhosted.org/packages/6b/b6/82c7e601d6d3c3278c40b7bd35e17e82aa227f050aa9f66cb7b7fce29471
PYTHON_FIRE_SETUP_TYPE = setuptools
PYTHON_FIRE_LICENSE = Apache-2.0
PYTHON_FIRE_LICENSE_FILES = LICENSE

$(eval $(python-package))
