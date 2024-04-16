################################################################################
#
# mesa3d-demos
#
################################################################################

MESA3D_DEMOS_VERSION = 9.0.0
MESA3D_DEMOS_SOURCE = mesa-demos-$(MESA3D_DEMOS_VERSION).tar.xz
MESA3D_DEMOS_SITE = https://archive.mesa3d.org/demos
MESA3D_DEMOS_DEPENDENCIES = host-pkgconf
MESA3D_DEMOS_LICENSE = MIT

MESA3D_DEMOS_CONF_OPTS += \
	-Dgles1=disabled

ifeq ($(BR2_PACKAGE_XORG7)$(BR2_PACKAGE_HAS_LIBGL),yy)
MESA3D_DEMOS_DEPENDENCIES += libgl libglew libglu xlib_libX11 xlib_libXext
MESA3D_DEMOS_CONF_OPTS += -Dgl=enabled -Dx11=enabled
else
MESA3D_DEMOS_CONF_OPTS += -Dgl=disabled -Dx11=disabled
endif

ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
MESA3D_DEMOS_DEPENDENCIES += libegl
MESA3D_DEMOS_CONF_OPTS += -Degl=enabled
else
MESA3D_DEMOS_CONF_OPTS += -Degl=disabled
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
MESA3D_DEMOS_DEPENDENCIES += libgles
MESA3D_DEMOS_CONF_OPTS += -Dgles2=enabled
else
MESA3D_DEMOS_CONF_OPTS += -Dgles2=disabled
endif

ifeq ($(BR2_PACKAGE_LIBDRM),y)
MESA3D_DEMOS_DEPENDENCIES += libdrm
MESA3D_DEMOS_CONF_OPTS += -Dlibdrm=enabled
else
MESA3D_DEMOS_CONF_OPTS += -Dlibdrm=disabled
endif

ifeq ($(BR2_PACKAGE_MESA3D_GBM),y)
# Meson search for gbm, but has no option to enable/disable it. See:
# https://gitlab.freedesktop.org/mesa/demos/-/blob/mesa-demos-8.5.0/meson.build#L88
# We still add the dependency, if needed, to make sure it will always
# be detected.
MESA3D_DEMOS_DEPENDENCIES += mesa3d
endif

ifeq ($(BR2_PACKAGE_LIBFREEGLUT),y)
MESA3D_DEMOS_DEPENDENCIES += libfreeglut
MESA3D_DEMOS_CONF_OPTS += -Dwith-glut=$(STAGING_DIR)/usr
# osmesa support depends on glut
ifeq ($(BR2_PACKAGE_MESA3D_OSMESA_GALLIUM),y)
MESA3D_DEMOS_CONF_OPTS += -Dosmesa=enabled
else
MESA3D_DEMOS_CONF_OPTS += -Dosmesa=disabled
endif
else
MESA3D_DEMOS_CONF_OPTS += -Dosmesa=disabled
endif

ifeq ($(BR2_PACKAGE_LIBDECOR)$(BR2_PACKAGE_WAYLAND),yy)
MESA3D_DEMOS_DEPENDENCIES += libdecor libxkbcommon wayland
MESA3D_DEMOS_CONF_OPTS += -Dwayland=enabled
else
MESA3D_DEMOS_CONF_OPTS += -Dwayland=disabled
endif

$(eval $(meson-package))
