################################################################################
#
# libdecor
#
################################################################################

LIBDECOR_VERSION = 0.2.3
LIBDECOR_SITE = https://gitlab.freedesktop.org/libdecor/libdecor/-/archive/$(LIBDECOR_VERSION)
LIBDECOR_LICENSE = MIT
LIBDECOR_LICENSE_FILES = LICENSE
LIBDECOR_INSTALL_STAGING = YES
LIBDECOR_DEPENDENCIES = cairo pango wayland wayland-protocols
LIBDECOR_CONF_OPTS = -Ddemo=false

ifeq ($(BR2_PACKAGE_DBUS),y)
LIBDECOR_CONF_OPTS += -Ddbus=enabled
LIBDECOR_DEPENDENCIES += dbus
else
LIBDECOR_CONF_OPTS += -Ddbus=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
LIBDECOR_CONF_OPTS += -Dgtk=enabled
LIBDECOR_DEPENDENCIES += libgtk3
else
LIBDECOR_CONF_OPTS += -Dgtk=disabled
endif

$(eval $(meson-package))
