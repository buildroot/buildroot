################################################################################
#
# xdriver_xf86-video-mach64
#
################################################################################

XDRIVER_XF86_VIDEO_MACH64_VERSION = 6.9.7
XDRIVER_XF86_VIDEO_MACH64_SOURCE = xf86-video-mach64-$(XDRIVER_XF86_VIDEO_MACH64_VERSION).tar.xz
XDRIVER_XF86_VIDEO_MACH64_SITE = https://xorg.freedesktop.org/releases/individual/driver
XDRIVER_XF86_VIDEO_MACH64_LICENSE = MIT
XDRIVER_XF86_VIDEO_MACH64_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_MACH64_AUTORECONF = YES
XDRIVER_XF86_VIDEO_MACH64_DEPENDENCIES = xserver_xorg-server xorgproto

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
XDRIVER_XF86_VIDEO_MACH64_CONF_OPTS += --enable-dri
else
XDRIVER_XF86_VIDEO_MACH64_CONF_OPTS += --disable-dri
endif

$(eval $(autotools-package))
