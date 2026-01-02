################################################################################
#
# python-modbus-tk
#
################################################################################

PYTHON_MODBUS_TK_VERSION = 1.1.5
PYTHON_MODBUS_TK_SOURCE = modbus_tk-$(PYTHON_MODBUS_TK_VERSION).tar.gz
PYTHON_MODBUS_TK_SITE = https://files.pythonhosted.org/packages/53/28/bdfb29ce9bec76015bf3d3ad6103324a0575843ee4b20663c53cc389c227
PYTHON_MODBUS_TK_SETUP_TYPE = setuptools
PYTHON_MODBUS_TK_LICENSE = LGPL-2.1+
PYTHON_MODBUS_TK_LICENSE_FILES = license.txt copying.txt

$(eval $(python-package))
