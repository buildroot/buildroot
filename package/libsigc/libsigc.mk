################################################################################
#
# libsigc
#
################################################################################

LIBSIGC_VERSION_MAJOR = 3.4
LIBSIGC_VERSION = $(LIBSIGC_VERSION_MAJOR).0
LIBSIGC_SOURCE = libsigc++-$(LIBSIGC_VERSION).tar.xz
LIBSIGC_SITE = http://ftp.gnome.org/pub/GNOME/sources/libsigc++/$(LIBSIGC_VERSION_MAJOR)
LIBSIGC_INSTALL_STAGING = YES
LIBSIGC_LICENSE = LGPL-3.0+
LIBSIGC_LICENSE_FILES = COPYING
LIBSIGC_CONF_OPTS = \
	-Dbuild-examples=false \
	-Dbuild-tests=false \
	-Dvalidation=false

$(eval $(meson-package))
