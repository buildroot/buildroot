################################################################################
#
# python-pymodbus
#
################################################################################

PYTHON_PYMODBUS_VERSION = 3.11.2
PYTHON_PYMODBUS_SOURCE = pymodbus-$(PYTHON_PYMODBUS_VERSION).tar.gz
PYTHON_PYMODBUS_SITE = https://files.pythonhosted.org/packages/d1/28/34f667085cb162ac68be849e4ea1ced4c54d97b7d8099c11b27ec1cf2fa1
PYTHON_PYMODBUS_SETUP_TYPE = setuptools
PYTHON_PYMODBUS_LICENSE = BSD-3-Clause
PYTHON_PYMODBUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
