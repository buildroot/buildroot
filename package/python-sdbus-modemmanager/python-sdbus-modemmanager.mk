################################################################################
#
# python-sdbus-modemmanager
#
################################################################################

PYTHON_SDBUS_MODEMMANAGER_VERSION = 1.0.2
PYTHON_SDBUS_MODEMMANAGER_SOURCE = sdbus_modemmanager-$(PYTHON_SDBUS_MODEMMANAGER_VERSION).tar.gz
PYTHON_SDBUS_MODEMMANAGER_SITE = https://files.pythonhosted.org/packages/af/99/a17942d9abda13ad1f27f39e900e39852a6215b70e30b682b777dfeff818
PYTHON_SDBUS_MODEMMANAGER_SETUP_TYPE = setuptools
PYTHON_SDBUS_MODEMMANAGER_LICENSE = LGPL-2.1+
PYTHON_SDBUS_MODEMMANAGER_LICENSE_FILES = COPYING.LESSER

$(eval $(python-package))
