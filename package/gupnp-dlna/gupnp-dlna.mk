################################################################################
#
# gupnp-dlna
#
################################################################################

GUPNP_DLNA_VERSION_MAJOR = 0.12
GUPNP_DLNA_VERSION = $(GUPNP_DLNA_VERSION_MAJOR).0
GUPNP_DLNA_SOURCE = gupnp-dlna-$(GUPNP_DLNA_VERSION).tar.xz
GUPNP_DLNA_SITE = \
	https://download.gnome.org/sources/gupnp-dlna/$(GUPNP_DLNA_VERSION_MAJOR)
# COPYING contains LGPL-2.1 but all source files contain LPGL-2.0+
GUPNP_DLNA_LICENSE = LGPL-2.0+
GUPNP_DLNA_LICENSE_FILES = COPYING
GUPNP_DLNA_INSTALL_STAGING = YES
GUPNP_DLNA_DEPENDENCIES = host-pkgconf libglib2 libxml2

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
GUPNP_DLNA_CONF_OPTS += -Dintrospection=true -Dvapi=true
GUPNP_DLNA_DEPENDENCIES += host-vala gobject-introspection
else
GUPNP_DLNA_CONF_OPTS += -Dintrospection=false -Dvapi=false
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BASE):$(BR2_STATIC_LIBS),y:)
GUPNP_DLNA_CONF_OPTS += -Dgstreamer_backend=enabled
GUPNP_DLNA_DEPENDENCIES += gstreamer1 gst1-plugins-base
else
GUPNP_DLNA_CONF_OPTS += -Dgstreamer_backend=disabled
endif

$(eval $(meson-package))
