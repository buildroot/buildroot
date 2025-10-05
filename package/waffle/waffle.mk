################################################################################
#
# waffle
#
################################################################################

WAFFLE_VERSION = v1.8.0-95-g5f1f48287e806544d745e9a8f5aed47234c61292
WAFFLE_SITE = https://gitlab.freedesktop.org/mesa/waffle.git
WAFFLE_SITE_METHOD = git
WAFFLE_INSTALL_STAGING = YES
WAFFLE_LICENSE = BSD-2-Clause
WAFFLE_LICENSE_FILES = LICENSE.txt

WAFFLE_DEPENDENCIES = host-pkgconf

WAFFLE_CONF_OPTS = \
	-Dbuild.pkg_config_path=$(STAGING_DIR)/usr/lib/pkgconfig \
	-Dbuild-tests=false \
	-Dbuild-examples=false \
	-Dbuild-manpages=false \
	-Dbuild-htmldocs=false \
	-Dnacl=false

ifeq ($(BR2_PACKAGE_WAFFLE_SUPPORTS_WAYLAND),y)
WAFFLE_DEPENDENCIES += libegl wayland
WAFFLE_CONF_OPTS += -Dwayland=enabled
else
WAFFLE_CONF_OPTS += -Dwayland=disabled
endif

ifeq ($(BR2_PACKAGE_WAFFLE_SUPPORTS_X11_EGL),y)
WAFFLE_DEPENDENCIES += libegl libxcb xlib_libX11
WAFFLE_CONF_OPTS += -Dx11_egl=enabled
else
WAFFLE_CONF_OPTS += -Dx11_egl=disabled
endif

ifeq ($(BR2_PACKAGE_WAFFLE_SUPPORTS_GLX),y)
WAFFLE_DEPENDENCIES += libgl libxcb xlib_libX11
WAFFLE_CONF_OPTS += -Dglx=enabled
else
WAFFLE_CONF_OPTS += -Dglx=disabled
endif

ifeq ($(BR2_PACKAGE_WAFFLE_SUPPORTS_GBM),y)
WAFFLE_DEPENDENCIES += libegl udev
WAFFLE_CONF_OPTS += -Dgbm=enabled
else
WAFFLE_CONF_OPTS += -Dgbm=disabled
endif

ifeq ($(BR2_PACKAGE_BASH_COMPLETION),y)
WAFFLE_DEPENDENCIES += bash-completion
endif

ifeq ($(BR2_PACKAGE_MESA3D)$(BR2_PACKAGE_MESA3D_OPENGL_EGL),yy)
WAFFLE_DEPENDENCIES += mesa3d
WAFFLE_CONF_OPTS += -Dsurfaceless_egl=enabled
else
WAFFLE_CONF_OPTS += -Dsurfaceless_egl=disabled
endif

$(eval $(meson-package))
