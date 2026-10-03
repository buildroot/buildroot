################################################################################
#
# python-libusb1
#
################################################################################

PYTHON_LIBUSB1_VERSION = 3.4.0
PYTHON_LIBUSB1_SOURCE = libusb1-$(PYTHON_LIBUSB1_VERSION).tar.gz
PYTHON_LIBUSB1_SITE = https://files.pythonhosted.org/packages/89/35/f9d2a990d092d647b47540cd229e1d68432c0f51183484ca189612a4824c
PYTHON_LIBUSB1_SETUP_TYPE = setuptools
PYTHON_LIBUSB1_LICENSE = LGPL-2.1+
PYTHON_LIBUSB1_LICENSE_FILES = COPYING.LESSER
PYTHON_LIBUSB1_DEPENDENCIES = libusb

$(eval $(python-package))
