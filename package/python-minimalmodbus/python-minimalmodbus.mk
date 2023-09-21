################################################################################
#
# python-minimalmodbus
#
################################################################################

PYTHON_MINIMALMODBUS_VERSION = 2.1.1
PYTHON_MINIMALMODBUS_SOURCE = minimalmodbus-$(PYTHON_MINIMALMODBUS_VERSION).tar.gz
PYTHON_MINIMALMODBUS_SITE = https://files.pythonhosted.org/packages/37/fc/8a58f7bcdece751f16a4a9aac780acd1288aa8ac6adbffdd764c88fb71c6
PYTHON_MINIMALMODBUS_DEPENDENCIES = host-python-setuptools
PYTHON_MINIMALMODBUS_SETUP_TYPE = pep517
PYTHON_MINIMALMODBUS_LICENSE = Apache-2.0
PYTHON_MINIMALMODBUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
