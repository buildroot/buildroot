################################################################################
#
# dmenu-wayland
#
################################################################################

DMENU_WAYLAND_VERSION = a380201dff5bfac2dace553d7eaedb6cea6855f9
DMENU_WAYLAND_SITE = $(call github,nyyManni,dmenu-wayland,$(DMENU_WAYLAND_VERSION))
DMENU_WAYLAND_LICENSE = MIT
DMENU_WAYLAND_LICENSE_FILES = LICENSE

# host-wayland is for wayland-scanner
DMENU_WAYLAND_DEPENDENCIES = \
	host-wayland \
	cairo \
	libglib2 \
	libxkbcommon \
	pango \
	wayland \
	wayland-protocols

# By default, sway calls dmenu not dmenu-wl
define DMENU_WAYLAND_SYMLINK_DMENU_WL
	ln -sf dmenu-wl $(TARGET_DIR)/usr/bin/dmenu
endef
DMENU_WAYLAND_POST_INSTALL_TARGET_HOOKS += DMENU_WAYLAND_SYMLINK_DMENU_WL

$(eval $(meson-package))
