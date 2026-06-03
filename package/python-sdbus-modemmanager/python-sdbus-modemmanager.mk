################################################################################
#
# python-sdbus-modemmanager
#
################################################################################

PYTHON_SDBUS_MODEMMANAGER_VERSION = 1.0.5
PYTHON_SDBUS_MODEMMANAGER_SOURCE = sdbus_modemmanager-$(PYTHON_SDBUS_MODEMMANAGER_VERSION).tar.gz
PYTHON_SDBUS_MODEMMANAGER_SITE = https://files.pythonhosted.org/packages/4e/fe/9ddd6c51aac270339b47708732112491c0dc690094bd8210253ce934285b
PYTHON_SDBUS_MODEMMANAGER_SETUP_TYPE = poetry
PYTHON_SDBUS_MODEMMANAGER_LICENSE = LGPL-2.1+
PYTHON_SDBUS_MODEMMANAGER_LICENSE_FILES = COPYING.LESSER

$(eval $(python-package))
