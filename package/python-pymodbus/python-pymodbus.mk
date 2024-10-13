################################################################################
#
# python-pymodbus
#
################################################################################

PYTHON_PYMODBUS_VERSION = 3.7.3
PYTHON_PYMODBUS_SOURCE = pymodbus-$(PYTHON_PYMODBUS_VERSION).tar.gz
PYTHON_PYMODBUS_SITE = https://files.pythonhosted.org/packages/af/33/3ccba09863981b2a3977933aa583b66ab65084bcb94aae4ec94ac23c9e39
PYTHON_PYMODBUS_SETUP_TYPE = setuptools
PYTHON_PYMODBUS_LICENSE = BSD-3-Clause
PYTHON_PYMODBUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
