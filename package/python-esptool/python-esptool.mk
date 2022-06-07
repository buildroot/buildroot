################################################################################
#
# python-esptool
#
################################################################################

PYTHON_ESPTOOL_VERSION = 4.0
PYTHON_ESPTOOL_SOURCE = esptool-$(PYTHON_ESPTOOL_VERSION).tar.gz
PYTHON_ESPTOOL_SITE = https://files.pythonhosted.org/packages/2d/91/76dac7a2c87172ee01e3e6e9ee17afb0b732065d49b476fef65c1ff8a386
PYTHON_ESPTOOL_SETUP_TYPE = setuptools
PYTHON_ESPTOOL_LICENSE = GPL-2.0+
PYTHON_ESPTOOL_LICENSE_FILES = LICENSE

$(eval $(python-package))
