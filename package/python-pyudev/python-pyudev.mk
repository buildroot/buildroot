################################################################################
#
# python-pyudev
#
################################################################################

PYTHON_PYUDEV_VERSION = 0.24.5
PYTHON_PYUDEV_SOURCE = pyudev-$(PYTHON_PYUDEV_VERSION).tar.gz
PYTHON_PYUDEV_SITE = https://files.pythonhosted.org/packages/6a/45/770eda636216c62be4a06af01c7235923ca0580d72fd3e3178fb01b3ae01
PYTHON_PYUDEV_LICENSE = LGPL-2.1+
PYTHON_PYUDEV_LICENSE_FILES = COPYING
PYTHON_PYUDEV_SETUP_TYPE = setuptools

$(eval $(python-package))
