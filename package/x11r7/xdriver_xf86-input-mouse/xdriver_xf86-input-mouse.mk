################################################################################
#
# xdriver_xf86-input-mouse
#
################################################################################

XDRIVER_XF86_INPUT_MOUSE_VERSION = 1.9.5
XDRIVER_XF86_INPUT_MOUSE_SOURCE = xf86-input-mouse-$(XDRIVER_XF86_INPUT_MOUSE_VERSION).tar.xz
XDRIVER_XF86_INPUT_MOUSE_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_INPUT_MOUSE_LICENSE = MIT
XDRIVER_XF86_INPUT_MOUSE_LICENSE_FILES = COPYING
XDRIVER_XF86_INPUT_MOUSE_DEPENDENCIES = xserver_xorg-server xorgproto
XDRIVER_XF86_INPUT_MOUSE_AUTORECONF = YES

$(eval $(autotools-package))
