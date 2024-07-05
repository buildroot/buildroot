################################################################################
#
# python-sdbus-networkmanager
#
################################################################################

PYTHON_SDBUS_NETWORKMANAGER_VERSION = 2.0.0
PYTHON_SDBUS_NETWORKMANAGER_SOURCE = sdbus-networkmanager-$(PYTHON_SDBUS_NETWORKMANAGER_VERSION).tar.gz
PYTHON_SDBUS_NETWORKMANAGER_SITE = https://files.pythonhosted.org/packages/31/ab/e864c6c2eb778c194cfb56cd9d98b5594dc00573210fdf6b44904745a0bf
PYTHON_SDBUS_NETWORKMANAGER_SETUP_TYPE = setuptools
PYTHON_SDBUS_NETWORKMANAGER_LICENSE = LGPL-2.1+
PYTHON_SDBUS_NETWORKMANAGER_LICENSE_FILES = COPYING

$(eval $(python-package))
