################################################################################
#
# python-minimalmodbus
#
################################################################################

PYTHON_MINIMALMODBUS_VERSION = 2.0.1
PYTHON_MINIMALMODBUS_SOURCE = minimalmodbus-$(PYTHON_MINIMALMODBUS_VERSION).tar.gz
PYTHON_MINIMALMODBUS_SITE = https://files.pythonhosted.org/packages/78/99/8cd22b4465e697bae2b02fd06aaccd4c5cdfbb18945d728db99f23d71df9
PYTHON_MINIMALMODBUS_SETUP_TYPE = setuptools
PYTHON_MINIMALMODBUS_LICENSE = Apache-2.0
PYTHON_MINIMALMODBUS_LICENSE_FILES = LICENSE

$(eval $(python-package))
