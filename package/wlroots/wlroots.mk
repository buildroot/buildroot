################################################################################
#
# wlroots
#
################################################################################

WLROOTS_VERSION = 0.15.1
WLROOTS_SITE = https://gitlab.freedesktop.org/wlroots/wlroots/-/releases/$(WLROOTS_VERSION)/downloads
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

WLROOTS_CONF_OPTS = -Dexamples=false -Dxcb-errors=disabled

WLROOTS_RENDERERS = gles2
WLROOTS_BACKENDS = libinput drm

ifeq ($(BR2_PACKAGE_WLROOTS_X11),y)
WLROOTS_BACKENDS += x11
WLROOTS_DEPENDENCIES += libxcb xcb-util-wm xcb-util-renderutil xlib_libX11
endif

ifeq ($(BR2_PACKAGE_WLROOTS_XWAYLAND),y)
WLROOTS_CONF_OPTS += -Dxwayland=enabled
WLROOTS_DEPENDENCIES += libxcb xcb-util-wm xwayland
else
WLROOTS_CONF_OPTS += -Dxwayland=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_VULKAN_DRIVER),y)
WLROOTS_RENDERERS += vulkan
WLROOTS_DEPENDENCIES += mesa3d
endif

WLROOTS_CONF_OPTS += \
	-Dbackends=$(subst $(space),$(comma),$(strip $(WLROOTS_BACKENDS))) \
	-Drenderers=$(subst $(space),$(comma),$(strip $(WLROOTS_RENDERERS)))

$(eval $(meson-package))
