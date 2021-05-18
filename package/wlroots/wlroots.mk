################################################################################
#
# wlroots
#
################################################################################

WLROOTS_VERSION = 0.13.0
WLROOTS_SITE = https://github.com/swaywm/wlroots/releases/download/$(WLROOTS_VERSION)
WLROOTS_LICENSE = MIT
WLROOTS_LICENSE_FILES = LICENSE
WLROOTS_INSTALL_STAGING = YES

WLROOTS_DEPENDENCIES = \
	host-pkgconf \
	host-wayland \
	libinput \
	libxkbcommon \
	libegl \
	libgles \
	pixman \
	udev \
	wayland \
	wayland-protocols

WLROOTS_CONF_OPTS = -Dexamples=false -Dxcb-errors=disabled -Dlibseat=disabled

ifeq ($(BR2_PACKAGE_FFMPEG),y)
WLROOTS_DEPENDENCIES += ffmpeg
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
WLROOTS_DEPENDENCIES += libpng
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_LOGIND),y)
WLROOTS_CONF_OPTS += -Dlogind=enabled -Dlogind-provider=systemd
WLROOTS_DEPENDENCIES += systemd
else
WLROOTS_CONF_OPTS += -Dlogind=disabled
endif

ifeq ($(BR2_PACKAGE_WLROOTS_X11),y)
WLROOTS_CONF_OPTS += -Dx11-backend=enabled -Dxwayland=enabled
WLROOTS_DEPENDENCIES += libxcb xcb-util-wm xcb-util-renderutil xlib_libX11
else
WLROOTS_CONF_OPTS += -Dx11-backend=disabled -Dxwayland=disabled
endif

$(eval $(meson-package))
