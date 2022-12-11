################################################################################
#
# xdriver_xf86-video-vesa
#
################################################################################

XDRIVER_XF86_VIDEO_VESA_VERSION = 2.6.0
XDRIVER_XF86_VIDEO_VESA_SOURCE = xf86-video-vesa-$(XDRIVER_XF86_VIDEO_VESA_VERSION).tar.xz
XDRIVER_XF86_VIDEO_VESA_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_VESA_LICENSE = MIT
XDRIVER_XF86_VIDEO_VESA_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_VESA_DEPENDENCIES = xserver_xorg-server xorgproto

$(eval $(autotools-package))
