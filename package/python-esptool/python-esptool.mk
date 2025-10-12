################################################################################
#
# python-esptool
#
################################################################################

PYTHON_ESPTOOL_VERSION = 5.1.0
PYTHON_ESPTOOL_SOURCE = esptool-$(PYTHON_ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE = https://files.pythonhosted.org/packages/c2/03/d7d79a77dd787dbe6029809c5f81ad88912340a131c88075189f40df3aba
PYTHON_ESPTOOL_SETUP_TYPE = setuptools
PYTHON_ESPTOOL_LICENSE = GPL-2.0+
PYTHON_ESPTOOL_LICENSE_FILES = LICENSE
PYTHON_ESPTOOL_CPE_ID_VENDOR = espressif
PYTHON_ESPTOOL_CPE_ID_PRODUCT = esptool

$(eval $(python-package))
