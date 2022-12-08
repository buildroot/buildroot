################################################################################
#
# xdriver_xf86-video-r128
#
################################################################################

XDRIVER_XF86_VIDEO_R128_VERSION = 6.12.1
XDRIVER_XF86_VIDEO_R128_SOURCE = xf86-video-r128-$(XDRIVER_XF86_VIDEO_R128_VERSION).tar.xz
XDRIVER_XF86_VIDEO_R128_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_R128_LICENSE = MIT
XDRIVER_XF86_VIDEO_R128_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_R128_DEPENDENCIES = xserver_xorg-server xorgproto

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
XDRIVER_XF86_VIDEO_R128_CONF_OPTS += --enable-dri
else
XDRIVER_XF86_VIDEO_R128_CONF_OPTS += --disable-dri
endif

$(eval $(autotools-package))
