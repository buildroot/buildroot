################################################################################
#
# xdriver_xf86-video-i128
#
################################################################################

XDRIVER_XF86_VIDEO_I128_VERSION = 1.4.1
XDRIVER_XF86_VIDEO_I128_SOURCE = xf86-video-i128-$(XDRIVER_XF86_VIDEO_I128_VERSION).tar.xz
XDRIVER_XF86_VIDEO_I128_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_I128_LICENSE = MIT
XDRIVER_XF86_VIDEO_I128_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_I128_DEPENDENCIES = xserver_xorg-server xorgproto

$(eval $(autotools-package))
