################################################################################
#
# python-fire
#
################################################################################

PYTHON_FIRE_VERSION = 0.4.0
PYTHON_FIRE_SOURCE = fire-$(PYTHON_FIRE_VERSION).tar.gz
PYTHON_FIRE_SITE = https://files.pythonhosted.org/packages/11/07/a119a1aa04d37bc819940d95ed7e135a7dcca1c098123a3764a6dcace9e7
PYTHON_FIRE_SETUP_TYPE = setuptools
PYTHON_FIRE_LICENSE = Apache-2.0
PYTHON_FIRE_LICENSE_FILES = LICENSE

$(eval $(python-package))
