################################################################################
#
# xdriver_xf86-video-voodoo
#
################################################################################

XDRIVER_XF86_VIDEO_VOODOO_VERSION = 1.2.6
XDRIVER_XF86_VIDEO_VOODOO_SOURCE = xf86-video-voodoo-$(XDRIVER_XF86_VIDEO_VOODOO_VERSION).tar.xz
XDRIVER_XF86_VIDEO_VOODOO_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_VOODOO_LICENSE = MIT
XDRIVER_XF86_VIDEO_VOODOO_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_VOODOO_DEPENDENCIES = xserver_xorg-server xorgproto

$(eval $(autotools-package))
