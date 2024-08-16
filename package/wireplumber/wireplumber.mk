################################################################################
#
# wireplumber
#
################################################################################

WIREPLUMBER_VERSION = 0.5.5
WIREPLUMBER_SOURCE = wireplumber-$(WIREPLUMBER_VERSION).tar.bz2
WIREPLUMBER_SITE = https://gitlab.freedesktop.org/pipewire/wireplumber/-/archive/$(WIREPLUMBER_VERSION)
WIREPLUMBER_LICENSE = MIT
WIREPLUMBER_LICENSE_FILES = LICENSE
WIREPLUMBER_DEPENDENCIES = host-pkgconf pipewire libglib2 lua

WIREPLUMBER_CONF_OPTS = \
	-Ddoc=disabled \
	-Dtests=false \
	-Delogind=disabled \
	-Dsystem-lua=true \
	-Dsystem-lua-version=

ifeq ($(BR2_PACKAGE_DBUS),y)
WIREPLUMBER_DEPENDENCIES += dbus
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
WIREPLUMBER_DEPENDENCIES += host-doxygen host-python-lxml gobject-introspection
WIREPLUMBER_CONF_OPTS += -Dintrospection=enabled
else
WIREPLUMBER_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
WIREPLUMBER_DEPENDENCIES += systemd
WIREPLUMBER_CONF_OPTS += \
	-Dsystemd=enabled \
	-Dsystemd-system-service=true \
	-Dsystemd-user-service=true
else
WIREPLUMBER_CONF_OPTS += \
	-Dsystemd=disabled \
	-Dsystemd-system-service=false \
	-Dsystemd-user-service=false
endif

$(eval $(meson-package))
