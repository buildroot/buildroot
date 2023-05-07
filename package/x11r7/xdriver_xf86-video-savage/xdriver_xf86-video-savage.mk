################################################################################
#
# xdriver_xf86-video-savage
#
################################################################################

XDRIVER_XF86_VIDEO_SAVAGE_VERSION = 2.4.0
XDRIVER_XF86_VIDEO_SAVAGE_SOURCE = xf86-video-savage-$(XDRIVER_XF86_VIDEO_SAVAGE_VERSION).tar.xz
XDRIVER_XF86_VIDEO_SAVAGE_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_SAVAGE_LICENSE = MIT
XDRIVER_XF86_VIDEO_SAVAGE_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_SAVAGE_DEPENDENCIES = xserver_xorg-server libdrm xorgproto

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
XDRIVER_XF86_VIDEO_SAVAGE_CONF_OPTS += --enable-dri
else
XDRIVER_XF86_VIDEO_SAVAGE_CONF_OPTS += --disable-dri
endif

$(eval $(autotools-package))
