################################################################################
#
# python-libusb1
#
################################################################################

PYTHON_LIBUSB1_VERSION = 3.0.0
PYTHON_LIBUSB1_SOURCE = libusb1-$(PYTHON_LIBUSB1_VERSION).tar.gz
PYTHON_LIBUSB1_SITE = https://files.pythonhosted.org/packages/f4/83/59bf75e74e0c4859ea63eae0c7da660c1dcb78b31667d4a5f735d52f5974
PYTHON_LIBUSB1_SETUP_TYPE = setuptools
PYTHON_LIBUSB1_LICENSE = LGPL-2.1+
PYTHON_LIBUSB1_LICENSE_FILES = COPYING.LESSER
PYTHON_LIBUSB1_DEPENDENCIES = libusb

$(eval $(python-package))
