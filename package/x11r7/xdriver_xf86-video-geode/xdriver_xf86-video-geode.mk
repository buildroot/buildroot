################################################################################
#
# xdriver_xf86-video-geode
#
################################################################################

XDRIVER_XF86_VIDEO_GEODE_VERSION = 2.11.21
XDRIVER_XF86_VIDEO_GEODE_SOURCE = xf86-video-geode-$(XDRIVER_XF86_VIDEO_GEODE_VERSION).tar.xz
XDRIVER_XF86_VIDEO_GEODE_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_GEODE_LICENSE = MIT
XDRIVER_XF86_VIDEO_GEODE_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_GEODE_DEPENDENCIES = xserver_xorg-server xorgproto

$(eval $(autotools-package))
