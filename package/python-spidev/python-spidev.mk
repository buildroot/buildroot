################################################################################
#
# python-spidev
#
################################################################################

PYTHON_SPIDEV_VERSION = 3.6
PYTHON_SPIDEV_SOURCE = spidev-$(PYTHON_SPIDEV_VERSION).tar.gz
PYTHON_SPIDEV_SITE = https://files.pythonhosted.org/packages/c7/d9/401c0a7be089e02826cf2c201f489876b601f15be100fe391ef9c2faed83
PYTHON_SPIDEV_SETUP_TYPE = setuptools
PYTHON_SPIDEV_LICENSE = MIT
PYTHON_SPIDEV_LICENSE_FILES = LICENSE

$(eval $(python-package))
