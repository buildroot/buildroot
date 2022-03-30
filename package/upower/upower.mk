################################################################################
#
# upower
#
################################################################################

UPOWER_VERSION = 0.99.11
UPOWER_SOURCE = upower-$(UPOWER_VERSION).tar.xz
UPOWER_SITE = https://upower.freedesktop.org/releases
UPOWER_LICENSE = GPL-2.0+
UPOWER_LICENSE_FILES = COPYING

# libupower-glib.so
UPOWER_INSTALL_STAGING = YES

UPOWER_DEPENDENCIES = \
	$(TARGET_NLS_DEPENDENCIES) \
	host-pkgconf \
	libgudev \
	libusb \
	udev

UPOWER_CONF_OPTS = --disable-man-pages --disable-tests

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
UPOWER_CONF_OPTS += --enable-introspection
UPOWER_DEPENDENCIES += gobject-introspection
else
UPOWER_CONF_OPTS += --disable-introspection
endif

$(eval $(autotools-package))
