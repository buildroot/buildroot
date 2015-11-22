################################################################################
#
# libfprint
#
################################################################################

LIBFPRINT_VERSION = 0.5.1
LIBFPRINT_SOURCE = libfprint-$(LIBFPRINT_VERSION).tar.xz
LIBFPRINT_SITE = http://people.freedesktop.org/~hadess
LIBFPRINT_LICENSE = LGPLv2.1+
LIBFPRINT_LICENSE_FILES = COPYING
LIBFPRINT_INSTALL_STAGING = YES
LIBFPRINT_DEPENDENCIES = host-pkgconf libusb libnss gdk-pixbuf
LIBFPRINT_AUTORECONF = YES

LIBFPRINT_CONF_OPTS = --disable-udev-rules

$(eval $(autotools-package))
