################################################################################
#
# xdriver_xf86-video-nv
#
################################################################################

XDRIVER_XF86_VIDEO_NV_VERSION = 2.1.22
XDRIVER_XF86_VIDEO_NV_SOURCE = xf86-video-nv-$(XDRIVER_XF86_VIDEO_NV_VERSION).tar.xz
XDRIVER_XF86_VIDEO_NV_SITE = https://xorg.freedesktop.org/releases/individual/driver
XDRIVER_XF86_VIDEO_NV_LICENSE = MIT
XDRIVER_XF86_VIDEO_NV_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_NV_DEPENDENCIES = xserver_xorg-server xorgproto

$(eval $(autotools-package))
