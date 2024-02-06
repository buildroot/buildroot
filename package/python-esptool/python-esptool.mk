################################################################################
#
# python-esptool
#
################################################################################

PYTHON_ESPTOOL_VERSION = 4.7.0
PYTHON_ESPTOOL_SOURCE = esptool-$(PYTHON_ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE = https://files.pythonhosted.org/packages/1b/8b/f0d1e75879dee053874a4f955ed1e9ad97275485f51cb4bc2cb4e9b24479
PYTHON_ESPTOOL_SETUP_TYPE = setuptools
PYTHON_ESPTOOL_LICENSE = GPL-2.0+
PYTHON_ESPTOOL_LICENSE_FILES = LICENSE
PYTHON_ESPTOOL_CPE_ID_VENDOR = espressif
PYTHON_ESPTOOL_CPE_ID_PRODUCT = esptool

$(eval $(python-package))
