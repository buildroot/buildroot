################################################################################
#
# wayland-protocols
#
################################################################################

WAYLAND_PROTOCOLS_VERSION = 1.42
WAYLAND_PROTOCOLS_SITE = https://gitlab.freedesktop.org/wayland/wayland-protocols/-/releases/$(WAYLAND_PROTOCOLS_VERSION)/downloads
WAYLAND_PROTOCOLS_SOURCE = wayland-protocols-$(WAYLAND_PROTOCOLS_VERSION).tar.xz
WAYLAND_PROTOCOLS_LICENSE = MIT
WAYLAND_PROTOCOLS_LICENSE_FILES = COPYING
WAYLAND_PROTOCOLS_INSTALL_STAGING = YES
WAYLAND_PROTOCOLS_INSTALL_TARGET = NO
# needs wayland-scanner
WAYLAND_PROTOCOLS_DEPENDENCIES = host-wayland

WAYLAND_PROTOCOLS_CONF_OPTS = -Dtests=false

$(eval $(meson-package))
