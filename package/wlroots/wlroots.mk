################################################################################
#
# wlroots
#
################################################################################

WLROOTS_VERSION = 0.14.1
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
	seatd \
	udev \
	wayland \
	wayland-protocols

WLROOTS_CONF_OPTS = -Dexamples=false -Dxcb-errors=disabled -Drenderers=gles2

ifeq ($(BR2_PACKAGE_FFMPEG),y)
WLROOTS_DEPENDENCIES += ffmpeg
endif

ifeq ($(BR2_PACKAGE_LIBPNG),y)
WLROOTS_DEPENDENCIES += libpng
endif

ifeq ($(BR2_PACKAGE_WLROOTS_X11),y)
WLROOTS_CONF_OPTS += -Dx11-backend=enabled -Dxwayland=enabled
WLROOTS_DEPENDENCIES += libxcb xcb-util-wm xcb-util-renderutil xlib_libX11
else
WLROOTS_CONF_OPTS += -Dx11-backend=disabled -Dxwayland=disabled
endif

$(eval $(meson-package))
