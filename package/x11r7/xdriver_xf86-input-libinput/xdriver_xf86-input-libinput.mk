################################################################################
#
# xdriver_xf86-input-libinput
#
################################################################################

XDRIVER_XF86_INPUT_LIBINPUT_VERSION = 1.2.1
XDRIVER_XF86_INPUT_LIBINPUT_SOURCE = xf86-input-libinput-$(XDRIVER_XF86_INPUT_LIBINPUT_VERSION).tar.xz
XDRIVER_XF86_INPUT_LIBINPUT_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_INPUT_LIBINPUT_LICENSE = MIT
XDRIVER_XF86_INPUT_LIBINPUT_LICENSE_FILES = COPYING
XDRIVER_XF86_INPUT_LIBINPUT_DEPENDENCIES = libinput xserver_xorg-server xorgproto
XDRIVER_XF86_INPUT_LIBINPUT_AUTORECONF = YES

$(eval $(autotools-package))
