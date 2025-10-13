################################################################################
#
# python-spidev
#
################################################################################

PYTHON_SPIDEV_VERSION = 3.8
PYTHON_SPIDEV_SOURCE = spidev-$(PYTHON_SPIDEV_VERSION).tar.gz
PYTHON_SPIDEV_SITE = https://files.pythonhosted.org/packages/67/87/039b6eeea781598015b538691bc174cc0bf77df9d4d2d3b8bf9245c0de8c
PYTHON_SPIDEV_SETUP_TYPE = setuptools
PYTHON_SPIDEV_LICENSE = MIT
PYTHON_SPIDEV_LICENSE_FILES = LICENSE

$(eval $(python-package))
