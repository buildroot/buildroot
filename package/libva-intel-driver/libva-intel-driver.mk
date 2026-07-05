################################################################################
#
# libva-intel-driver
#
################################################################################

LIBVA_INTEL_DRIVER_VERSION = 2.4.5
LIBVA_INTEL_DRIVER_SITE = $(call github,irql-notlessorequal,intel-vaapi-driver,$(LIBVA_INTEL_DRIVER_VERSION))
LIBVA_INTEL_DRIVER_LICENSE = MIT
LIBVA_INTEL_DRIVER_LICENSE_FILES = LICENSE
LIBVA_INTEL_DRIVER_DEPENDENCIES = host-pkgconf libdrm libva

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBVA_INTEL_DRIVER_DEPENDENCIES += xlib_libX11 xlib_libXext xlib_libXfixes
LIBVA_INTEL_DRIVER_CONF_OPTS += -Dwith_x11=yes
else
LIBVA_INTEL_DRIVER_CONF_OPTS += -Dwith_x11=no
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBVA_INTEL_DRIVER_DEPENDENCIES += wayland
LIBVA_INTEL_DRIVER_CONF_OPTS += -Dwith_wayland_drm=yes
else
LIBVA_INTEL_DRIVER_CONF_OPTS += -Dwith_wayland_drm=no
endif

$(eval $(meson-package))
