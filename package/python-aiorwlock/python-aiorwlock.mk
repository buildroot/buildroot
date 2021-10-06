################################################################################
#
# python-aiorwlock
#
################################################################################

PYTHON_AIORWLOCK_VERSION = 1.1.0
PYTHON_AIORWLOCK_SOURCE = aiorwlock-$(PYTHON_AIORWLOCK_VERSION).tar.gz
PYTHON_AIORWLOCK_SITE = https://files.pythonhosted.org/packages/ca/e5/3221d49edb432024f6b1b7e9e36cad6363601973375667477f2130d5da7d
PYTHON_AIORWLOCK_SETUP_TYPE = setuptools
PYTHON_AIORWLOCK_LICENSE = Apache-2.0
PYTHON_AIORWLOCK_LICENSE_FILES = LICENSE

$(eval $(python-package))
