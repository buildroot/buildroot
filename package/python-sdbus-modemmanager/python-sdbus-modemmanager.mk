################################################################################
#
# python-sdbus-modemmanager
#
################################################################################

PYTHON_SDBUS_MODEMMANAGER_VERSION = 1.0.3
PYTHON_SDBUS_MODEMMANAGER_SOURCE = sdbus_modemmanager-$(PYTHON_SDBUS_MODEMMANAGER_VERSION).tar.gz
PYTHON_SDBUS_MODEMMANAGER_SITE = https://files.pythonhosted.org/packages/38/2c/d66aa7f981df1d654bf70942964a4ca24cf930815fe7d656e1979c44a33a
PYTHON_SDBUS_MODEMMANAGER_SETUP_TYPE = poetry
PYTHON_SDBUS_MODEMMANAGER_LICENSE = LGPL-2.1+
PYTHON_SDBUS_MODEMMANAGER_LICENSE_FILES = COPYING.LESSER

$(eval $(python-package))
