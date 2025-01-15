################################################################################
#
# python-modbus-tk
#
################################################################################

PYTHON_MODBUS_TK_VERSION = 1.1.4
PYTHON_MODBUS_TK_SOURCE = modbus_tk-$(PYTHON_MODBUS_TK_VERSION).tar.gz
PYTHON_MODBUS_TK_SITE = https://files.pythonhosted.org/packages/78/40/9ae5c428b1867bfccd3c184dcf18cfef04e3d9c5b9dc22b8e9eb8d480651
PYTHON_MODBUS_TK_SETUP_TYPE = setuptools
PYTHON_MODBUS_TK_LICENSE = LGPL-2.1+
PYTHON_MODBUS_TK_LICENSE_FILES = license.txt copying.txt

$(eval $(python-package))
