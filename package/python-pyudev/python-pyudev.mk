################################################################################
#
# python-pyudev
#
################################################################################

PYTHON_PYUDEV_VERSION = 0.24.1
PYTHON_PYUDEV_SOURCE = pyudev-$(PYTHON_PYUDEV_VERSION).tar.gz
PYTHON_PYUDEV_SITE = https://files.pythonhosted.org/packages/20/b6/16961ac3575575260c72928f17df9c99c2a696871e486965ec6e2fa2aff4
PYTHON_PYUDEV_LICENSE = LGPL-2.1+
PYTHON_PYUDEV_LICENSE_FILES = COPYING
PYTHON_PYUDEV_SETUP_TYPE = setuptools

$(eval $(python-package))
