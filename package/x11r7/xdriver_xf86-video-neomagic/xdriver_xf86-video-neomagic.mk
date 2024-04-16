################################################################################
#
# xdriver_xf86-video-neomagic
#
################################################################################

XDRIVER_XF86_VIDEO_NEOMAGIC_VERSION = 1.3.1
XDRIVER_XF86_VIDEO_NEOMAGIC_SOURCE = xf86-video-neomagic-$(XDRIVER_XF86_VIDEO_NEOMAGIC_VERSION).tar.xz
XDRIVER_XF86_VIDEO_NEOMAGIC_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_NEOMAGIC_LICENSE = MIT
XDRIVER_XF86_VIDEO_NEOMAGIC_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_NEOMAGIC_DEPENDENCIES = xserver_xorg-server xorgproto

$(eval $(autotools-package))
