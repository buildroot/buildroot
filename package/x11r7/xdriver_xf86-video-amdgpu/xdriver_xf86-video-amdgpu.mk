################################################################################
#
# xdriver_xf86-video-amdgpu
#
################################################################################

XDRIVER_XF86_VIDEO_AMDGPU_VERSION = 25.0.0
XDRIVER_XF86_VIDEO_AMDGPU_SOURCE = xf86-video-amdgpu-$(XDRIVER_XF86_VIDEO_AMDGPU_VERSION).tar.xz
XDRIVER_XF86_VIDEO_AMDGPU_SITE = https://xorg.freedesktop.org/archive/individual/driver
XDRIVER_XF86_VIDEO_AMDGPU_LICENSE = MIT
XDRIVER_XF86_VIDEO_AMDGPU_LICENSE_FILES = COPYING
XDRIVER_XF86_VIDEO_AMDGPU_DEPENDENCIES = \
	libdrm \
	libgbm \
	xlib_libXcomposite \
	xorgproto \
	xserver_xorg-server

ifeq ($(BR2_PACKAGE_HAS_LIBEGL)$(BR2_PACKAGE_HAS_LIBGL)$(BR2_PACKAGE_LIBEPOXY),yyy)
XDRIVER_XF86_VIDEO_AMDGPU_CONF_OPTS += -Dglamor=enabled
else
XDRIVER_XF86_VIDEO_AMDGPU_CONF_OPTS += -Dglamor=disabled
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
XDRIVER_XF86_VIDEO_AMDGPU_CONF_OPTS += -Dudev=enabled
XDRIVER_XF86_VIDEO_AMDGPU_DEPENDENCIES += udev
else
XDRIVER_XF86_VIDEO_AMDGPU_CONF_OPTS += -Dudev=disabled
endif

$(eval $(meson-package))
