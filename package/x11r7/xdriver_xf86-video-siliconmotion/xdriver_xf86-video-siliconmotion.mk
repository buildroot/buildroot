################################################################################
#
# xdriver_xf86-video-siliconmotion
#
################################################################################

XDRIVER_XF86_VIDEO_SILICONMOTION_VERSION = 1.7.10
XDRIVER_XF86_VIDEO_SILICONMOTION_SOURCE = xf86-video-siliconmotion-$(XDRIVER_XF86_VIDEO_SILICONMOTION_VERSION).tar.xz
XDRIVER_XF86_VIDEO_SILICONMOTION_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_SILICONMOTION_LICENSE = MIT
XDRIVER_XF86_VIDEO_SILICONMOTION_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_SILICONMOTION_DEPENDENCIES = xserver_xorg-server xorgproto

XDRIVER_XF86_VIDEO_SILICONMOTION_CONF_OPTS = --disable-selective-werror

$(eval $(autotools-package))
