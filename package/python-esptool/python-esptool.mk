################################################################################
#
# python-esptool
#
################################################################################

PYTHON_ESPTOOL_VERSION = 3.1
PYTHON_ESPTOOL_SOURCE = esptool-$(PYTHON_ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE = https://files.pythonhosted.org/packages/9c/c8/28f21b3d3b5e1f1d249be52cdd91793c8c3f7c4f4f255ece7d50984fb05d
PYTHON_ESPTOOL_SETUP_TYPE = setuptools
PYTHON_ESPTOOL_LICENSE = GPL-2.0+
PYTHON_ESPTOOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
