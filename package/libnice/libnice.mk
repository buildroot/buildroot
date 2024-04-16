################################################################################
#
# libnice
#
################################################################################

LIBNICE_VERSION = 0.1.21
LIBNICE_SITE = https://libnice.freedesktop.org/releases
LIBNICE_LICENSE = MPL-1.1 or LGPL-2.1
LIBNICE_LICENSE_FILES = COPYING COPYING.MPL COPYING.LGPL
LIBNICE_DEPENDENCIES = libglib2 host-pkgconf
LIBNICE_INSTALL_STAGING = YES
LIBNICE_CONF_OPTS = \
	-Dexamples=disabled \
	-Dtests=disabled

ifeq ($(BR2_PACKAGE_GNUTLS),y)
LIBNICE_CONF_OPTS += -Dcrypto-library=gnutls
LIBNICE_DEPENDENCIES += gnutls
else
LIBNICE_CONF_OPTS += -Dcrypto-library=openssl
LIBNICE_DEPENDENCIES += openssl
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
LIBNICE_CONF_OPTS += -Dintrospection=enabled
LIBNICE_DEPENDENCIES += gobject-introspection
else
LIBNICE_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BASE),y)
LIBNICE_CONF_OPTS += -Dgstreamer=enabled
LIBNICE_DEPENDENCIES += gst1-plugins-base
else
LIBNICE_CONF_OPTS += -Dgstreamer=disabled
endif

$(eval $(meson-package))
