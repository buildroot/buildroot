################################################################################
#
# python-esptool
#
################################################################################

PYTHON_ESPTOOL_VERSION = 3.2
PYTHON_ESPTOOL_SOURCE = esptool-$(PYTHON_ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE = https://files.pythonhosted.org/packages/60/a4/33907f5b735f9179061bd6b6cae7123d4a2d0cdf46c879fa55e66edef24f
PYTHON_ESPTOOL_SETUP_TYPE = setuptools
PYTHON_ESPTOOL_LICENSE = GPL-2.0+
PYTHON_ESPTOOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
