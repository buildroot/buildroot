################################################################################
#
# xdriver_xf86-input-evdev
#
################################################################################

XDRIVER_XF86_INPUT_EVDEV_VERSION = 2.11.0
XDRIVER_XF86_INPUT_EVDEV_SOURCE = xf86-input-evdev-$(XDRIVER_XF86_INPUT_EVDEV_VERSION).tar.xz
XDRIVER_XF86_INPUT_EVDEV_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_INPUT_EVDEV_LICENSE = MIT
XDRIVER_XF86_INPUT_EVDEV_LICENSE_FILES = COPYING
XDRIVER_XF86_INPUT_EVDEV_AUTORECONF = YES

XDRIVER_XF86_INPUT_EVDEV_DEPENDENCIES = \
	host-pkgconf \
	libevdev \
	mtdev \
	xorgproto \
	xserver_xorg-server \
	udev

$(eval $(autotools-package))
