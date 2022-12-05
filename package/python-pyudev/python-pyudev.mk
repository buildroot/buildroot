################################################################################
#
# python-pyudev
#
################################################################################

PYTHON_PYUDEV_VERSION = 0.24.0
PYTHON_PYUDEV_SOURCE = pyudev-$(PYTHON_PYUDEV_VERSION).tar.gz
PYTHON_PYUDEV_SITE = https://files.pythonhosted.org/packages/00/8d/810750cb2fc64d7e0dbefc106a9137b157616a95be3f0ea51ca3cf6c762a
PYTHON_PYUDEV_LICENSE = LGPL-2.1+
PYTHON_PYUDEV_LICENSE_FILES = COPYING
PYTHON_PYUDEV_SETUP_TYPE = setuptools

$(eval $(python-package))
