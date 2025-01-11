################################################################################
#
# python-libusb1
#
################################################################################

PYTHON_LIBUSB1_VERSION = 3.2.0
PYTHON_LIBUSB1_SOURCE = libusb1-$(PYTHON_LIBUSB1_VERSION).tar.gz
PYTHON_LIBUSB1_SITE = https://files.pythonhosted.org/packages/d9/b7/9e833af6cb52fa2aece1c6a1378667ca0172bead14f63ffccc3cb9862df3
PYTHON_LIBUSB1_SETUP_TYPE = setuptools
PYTHON_LIBUSB1_LICENSE = LGPL-2.1+
PYTHON_LIBUSB1_LICENSE_FILES = COPYING.LESSER
PYTHON_LIBUSB1_DEPENDENCIES = libusb

$(eval $(python-package))
