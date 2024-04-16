################################################################################
#
# libqrtr-glib
#
################################################################################

LIBQRTR_GLIB_VERSION = 1.2.2
LIBQRTR_GLIB_SITE = https://gitlab.freedesktop.org/mobile-broadband/libqrtr-glib/-/archive/$(LIBQRTR_GLIB_VERSION)
LIBQRTR_GLIB_LICENSE = LGPL-2.1+
LIBQRTR_GLIB_LICENSE_FILES = LICENSES/LGPL-2.1-or-later.txt
LIBQRTR_GLIB_INSTALL_STAGING = YES
LIBQRTR_GLIB_DEPENDENCIES = libglib2

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBQRTR_GLIB_CONF_OPTS += -Dintrospection=true
LIBQRTR_GLIB_DEPENDENCIES += gobject-introspection
else
LIBQRTR_GLIB_CONF_OPTS += -Dintrospection=false
endif

# disable gtkdocize
LIBQRTR_GLIB_CONF_OPTS += -Dgtk_doc=false

$(eval $(meson-package))
