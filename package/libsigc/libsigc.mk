################################################################################
#
# libsigc
#
################################################################################

LIBSIGC_VERSION_MAJOR = 2.10
LIBSIGC_VERSION = $(LIBSIGC_VERSION_MAJOR).6
LIBSIGC_SOURCE = libsigc++-$(LIBSIGC_VERSION).tar.xz
LIBSIGC_SITE = http://ftp.gnome.org/pub/GNOME/sources/libsigc++/$(LIBSIGC_VERSION_MAJOR)
LIBSIGC_INSTALL_STAGING = YES
LIBSIGC_LICENSE = LGPL-2.1+
LIBSIGC_LICENSE_FILES = COPYING
LIBSIGC_CONF_OPTS = \
	-Dbuild-examples=false \
	-Dvalidation=false

$(eval $(meson-package))
