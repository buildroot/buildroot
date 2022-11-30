################################################################################
#
# xdriver_xf86-video-cirrus
#
################################################################################

XDRIVER_XF86_VIDEO_CIRRUS_VERSION = 1.6.0
XDRIVER_XF86_VIDEO_CIRRUS_SOURCE = xf86-video-cirrus-$(XDRIVER_XF86_VIDEO_CIRRUS_VERSION).tar.xz
XDRIVER_XF86_VIDEO_CIRRUS_SITE = https://xorg.freedesktop.org/releases/individual/driver
XDRIVER_XF86_VIDEO_CIRRUS_LICENSE = MIT
XDRIVER_XF86_VIDEO_CIRRUS_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_CIRRUS_DEPENDENCIES = xserver_xorg-server xorgproto

$(eval $(autotools-package))
