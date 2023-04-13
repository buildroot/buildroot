################################################################################
#
# python-esptool
#
################################################################################

PYTHON_ESPTOOL_VERSION = 4.5.1
PYTHON_ESPTOOL_SOURCE = esptool-$(PYTHON_ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE = https://files.pythonhosted.org/packages/04/80/8eb97d1793cfaf830a4c0a7ea1d8f0674ccba8c23b7d02dcce074b5f44ea
PYTHON_ESPTOOL_SETUP_TYPE = setuptools
PYTHON_ESPTOOL_LICENSE = GPL-2.0+
PYTHON_ESPTOOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
