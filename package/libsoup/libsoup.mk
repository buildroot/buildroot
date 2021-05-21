################################################################################
#
# libsoup
#
################################################################################

LIBSOUP_VERSION_MAJOR = 2.66
LIBSOUP_VERSION = $(LIBSOUP_VERSION_MAJOR).5
LIBSOUP_SOURCE = libsoup-$(LIBSOUP_VERSION).tar.xz
LIBSOUP_SITE = http://ftp.gnome.org/pub/gnome/sources/libsoup/$(LIBSOUP_VERSION_MAJOR)
LIBSOUP_LICENSE = LGPL-2.0+
LIBSOUP_LICENSE_FILES = COPYING
LIBSOUP_CPE_ID_VENDOR = gnome
LIBSOUP_INSTALL_STAGING = YES
LIBSOUP_CONF_ENV = ac_cv_path_GLIB_GENMARSHAL=$(LIBGLIB2_HOST_BINARY)
LIBSOUP_CONF_OPTS = -Dtests=false -Dvapi=false -Dgssapi=false
LIBSOUP_DEPENDENCIES = host-pkgconf host-libglib2 \
	libglib2 libpsl libxml2 sqlite host-intltool

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBSOUP_CONF_OPTS += -Dintrospection=true
LIBSOUP_DEPENDENCIES += gobject-introspection
else
LIBSOUP_CONF_OPTS += -Dintrospection=false
endif

ifeq ($(BR2_PACKAGE_LIBSOUP_GNOME),y)
LIBSOUP_CONF_OPTS += -Dgnome=true
else
LIBSOUP_CONF_OPTS += -Dgnome=false
endif

ifeq ($(BR2_PACKAGE_LIBSOUP_SSL),y)
LIBSOUP_DEPENDENCIES += glib-networking
else
LIBSOUP_CONF_OPTS += -Dtls_check=false
endif

$(eval $(meson-package))
