################################################################################
#
# python-esptool
#
################################################################################

PYTHON_ESPTOOL_VERSION = 5.4.0
PYTHON_ESPTOOL_SOURCE = esptool-$(PYTHON_ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE = https://files.pythonhosted.org/packages/2c/43/1a2ae2dd8ae97bf1ec9991db097e52626d35b57d242f9687c9314eac5b57
PYTHON_ESPTOOL_SETUP_TYPE = setuptools
PYTHON_ESPTOOL_LICENSE = GPL-2.0+
PYTHON_ESPTOOL_LICENSE_FILES = LICENSE
PYTHON_ESPTOOL_CPE_ID_VENDOR = espressif
PYTHON_ESPTOOL_CPE_ID_PRODUCT = esptool

$(eval $(python-package))
