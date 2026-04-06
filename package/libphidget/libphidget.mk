################################################################################
#
# libphidget
#
################################################################################

LIBPHIDGET_VERSION = 1.24.20260127
LIBPHIDGET_SOURCE = libphidget22-$(LIBPHIDGET_VERSION).tar.gz
LIBPHIDGET_SITE = https://www.phidgets.com/downloads/phidget22/libraries/linux/libphidget22
LIBPHIDGET_DEPENDENCIES = libusb
LIBPHIDGET_CONF_OPTS = --disable-ldconfig
LIBPHIDGET_INSTALL_STAGING = YES
LIBPHIDGET_LICENSE = BSD-3-Clause
LIBPHIDGET_LICENSE_FILES = COPYING

$(eval $(autotools-package))
