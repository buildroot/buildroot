################################################################################
#
# libinput
#
################################################################################

LIBINPUT_VERSION = 1.20.1
LIBINPUT_SOURCE = libinput-$(LIBINPUT_VERSION).tar.bz2
LIBINPUT_SITE = https://gitlab.freedesktop.org/libinput/libinput/-/archive/$(LIBINPUT_VERSION)
LIBINPUT_DEPENDENCIES = host-pkgconf libevdev mtdev udev
LIBINPUT_INSTALL_STAGING = YES
LIBINPUT_LICENSE = MIT
LIBINPUT_LICENSE_FILES = COPYING
# Tests need fork, so just disable them everywhere.
LIBINPUT_CONF_OPTS = -Dtests=false -Dlibwacom=false -Ddocumentation=false

ifeq ($(BR2_PACKAGE_LIBGTK3),y)
LIBINPUT_CONF_OPTS += -Ddebug-gui=true
LIBINPUT_DEPENDENCIES += libgtk3
ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBINPUT_DEPENDENCIES += wayland
endif
ifeq ($(BR2_PACKAGE_WAYLAND_PROTOCOLS),y)
LIBINPUT_DEPENDENCIES += wayland-protocols
endif
ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
LIBINPUT_DEPENDENCIES += xlib_libX11
endif
else
LIBINPUT_CONF_OPTS += -Ddebug-gui=false
endif

$(eval $(meson-package))
