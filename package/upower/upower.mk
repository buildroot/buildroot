################################################################################
#
# upower
#
################################################################################

UPOWER_VERSION = 0.99.19
UPOWER_SOURCE = upower-v$(UPOWER_VERSION).tar.bz2
UPOWER_SITE = https://gitlab.freedesktop.org/upower/upower/-/archive/v$(UPOWER_VERSION)
UPOWER_LICENSE = GPL-2.0+
UPOWER_LICENSE_FILES = COPYING

# libupower-glib.so
UPOWER_INSTALL_STAGING = YES

UPOWER_DEPENDENCIES = \
	$(TARGET_NLS_DEPENDENCIES) \
	host-pkgconf \
	libgudev \
	udev

UPOWER_CONF_OPTS = \
	-Dgtk-doc=false \
	-Dman=false \
	-Dsystemdsystemunitdir=/usr/lib/systemd/system \
	-Dudevhwdbdir=/lib/udev/hwdb.d \
	-Dudevrulesdir=/lib/udev/rules.d

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
UPOWER_CONF_OPTS += -Dintrospection=enabled
UPOWER_DEPENDENCIES += gobject-introspection
else
UPOWER_CONF_OPTS += -Dintrospection=disabled
endif

$(eval $(meson-package))
