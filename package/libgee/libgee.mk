################################################################################
#
# libgee
#
################################################################################

LIBGEE_VERSION_MAJOR = 0.20
LIBGEE_VERSION = $(LIBGEE_VERSION_MAJOR).4
LIBGEE_SITE = http://ftp.gnome.org/pub/gnome/sources/libgee/$(LIBGEE_VERSION_MAJOR)
LIBGEE_SOURCE = libgee-$(LIBGEE_VERSION).tar.xz
LIBGEE_DEPENDENCIES = host-pkgconf host-vala libglib2
LIBGEE_INSTALL_STAGING = YES
LIBGEE_LICENSE = LGPL-2.1+
LIBGEE_LICENSE_FILES = COPYING
LIBGEE_CPE_ID_VENDOR = gnome
# We're patching gee/Makefile.am
LIBGEE_AUTORECONF = YES

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBGEE_CONF_OPTS += --enable-introspection
LIBGEE_DEPENDENCIES += gobject-introspection
else
LIBGEE_CONF_OPTS += --disable-introspection
endif

$(eval $(autotools-package))
