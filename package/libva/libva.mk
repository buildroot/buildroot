################################################################################
#
# libva
#
################################################################################

LIBVA_VERSION = 2.22.0
LIBVA_SITE = $(call github,intel,libva,$(LIBVA_VERSION))
LIBVA_LICENSE = MIT
LIBVA_LICENSE_FILES = COPYING
LIBVA_INSTALL_STAGING = YES
LIBVA_DEPENDENCIES = host-pkgconf libdrm
LIBVA_CFLAGS = $(TARGET_CFLAGS) -std=gnu99

# libdrm is a hard-dependency
LIBVA_CONF_OPTS = \
	-Ddisable_drm=false \
	-Ddriverdir="/usr/lib/va"

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBVA_DEPENDENCIES += xlib_libX11 xlib_libXext xlib_libXfixes
LIBVA_CONF_OPTS += -Dwith_x11=yes
ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
LIBVA_DEPENDENCIES += libgl
LIBVA_CONF_OPTS += -Dwith_glx=yes
endif
else
LIBVA_CONF_OPTS += -Dwith_glx=no -Dwith_x11=no
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBVA_DEPENDENCIES += wayland
LIBVA_CONF_OPTS += -Dwith_wayland=yes
else
LIBVA_CONF_OPTS += -Dwith_wayland=no
endif

$(eval $(meson-package))
