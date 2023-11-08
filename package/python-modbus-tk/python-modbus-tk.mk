################################################################################
#
# python-modbus-tk
#
################################################################################

PYTHON_MODBUS_TK_VERSION = 1.1.3
PYTHON_MODBUS_TK_SOURCE = modbus_tk-$(PYTHON_MODBUS_TK_VERSION).tar.gz
PYTHON_MODBUS_TK_SITE = https://files.pythonhosted.org/packages/8d/9f/5963e30dba160dbc646b76c59ca8136709c7fe9002bbaaa3cf1e1bb0404b
PYTHON_MODBUS_TK_SETUP_TYPE = setuptools
PYTHON_MODBUS_TK_LICENSE = LGPL-2.1+
PYTHON_MODBUS_TK_LICENSE_FILES = license.txt copying.txt

$(eval $(python-package))
