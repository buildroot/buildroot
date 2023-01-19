################################################################################
#
# libgudev
#
################################################################################

LIBGUDEV_VERSION = 237
LIBGUDEV_SOURCE = libgudev-$(LIBGUDEV_VERSION).tar.xz
LIBGUDEV_SITE = https://download.gnome.org/sources/libgudev/$(LIBGUDEV_VERSION)
LIBGUDEV_INSTALL_STAGING = YES
LIBGUDEV_DEPENDENCIES = host-pkgconf udev libglib2
LIBGUDEV_LICENSE = LGPL-2.1+
LIBGUDEV_LICENSE_FILES = COPYING
LIBGUDEV_CONF_OPTS = -Dtests=disabled -Dvapi=disabled

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBGUDEV_CONF_OPTS += -Dintrospection=enabled
LIBGUDEV_DEPENDENCIES += gobject-introspection
else
LIBGUDEV_CONF_OPTS += -Dintrospection=disabled
endif

$(eval $(meson-package))
