################################################################################
#
# python-spidev
#
################################################################################

PYTHON_SPIDEV_VERSION = 3.7
PYTHON_SPIDEV_SOURCE = spidev-$(PYTHON_SPIDEV_VERSION).tar.gz
PYTHON_SPIDEV_SITE = https://files.pythonhosted.org/packages/b5/99/dd50af8200e224ce9412ad01cdbeeb5b39b2d61acd72138f2b92c4a6d619
PYTHON_SPIDEV_SETUP_TYPE = setuptools
PYTHON_SPIDEV_LICENSE = MIT
PYTHON_SPIDEV_LICENSE_FILES = LICENSE

$(eval $(python-package))
