################################################################################
#
# python-libusb1
#
################################################################################

PYTHON_LIBUSB1_VERSION = 3.3.1
PYTHON_LIBUSB1_SOURCE = libusb1-$(PYTHON_LIBUSB1_VERSION).tar.gz
PYTHON_LIBUSB1_SITE = https://files.pythonhosted.org/packages/a2/7f/c59ad56d1bca8fa4321d1bb77ba4687775751a4deceec14943a44da18ca0
PYTHON_LIBUSB1_SETUP_TYPE = setuptools
PYTHON_LIBUSB1_LICENSE = LGPL-2.1+
PYTHON_LIBUSB1_LICENSE_FILES = COPYING.LESSER
PYTHON_LIBUSB1_DEPENDENCIES = libusb

$(eval $(python-package))
