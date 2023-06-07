################################################################################
#
# at-spi2-core
#
################################################################################

AT_SPI2_CORE_VERSION_MAJOR = 2.48
AT_SPI2_CORE_VERSION = $(AT_SPI2_CORE_VERSION_MAJOR).3
AT_SPI2_CORE_SOURCE = at-spi2-core-$(AT_SPI2_CORE_VERSION).tar.xz
AT_SPI2_CORE_SITE = https://download.gnome.org/sources/at-spi2-core/$(AT_SPI2_CORE_VERSION_MAJOR)
AT_SPI2_CORE_LICENSE = LGPL-2.1+
AT_SPI2_CORE_LICENSE_FILES = COPYING
AT_SPI2_CORE_INSTALL_STAGING = YES
AT_SPI2_CORE_DEPENDENCIES = host-pkgconf dbus libglib2 libxml2 \
	$(TARGET_NLS_DEPENDENCIES)
AT_SPI2_CORE_CONF_OPTS = -Ddbus_daemon=/usr/bin/dbus-daemon

ifeq ($(BR2_PACKAGE_XORG7),y)
AT_SPI2_CORE_CONF_OPTS += -Dx11=enabled
AT_SPI2_CORE_DEPENDENCIES += xlib_libXtst
else
AT_SPI2_CORE_CONF_OPTS += -Dx11=disabled
endif

ifeq ($(BR2_PACKAGE_GOBJECT_INTROSPECTION),y)
AT_SPI2_CORE_CONF_OPTS += -Dintrospection=enabled
AT_SPI2_CORE_DEPENDENCIES += gobject-introspection
else
AT_SPI2_CORE_CONF_OPTS += -Dintrospection=disabled
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
AT_SPI2_CORE_CONF_OPTS += -Duse_systemd=true
AT_SPI2_CORE_DEPENDENCIES += systemd
else
AT_SPI2_CORE_CONF_OPTS += -Duse_systemd=false
endif

AT_SPI2_CORE_LDFLAGS = $(TARGET_LDFLAGS) $(TARGET_NLS_LIBS)

$(eval $(meson-package))
