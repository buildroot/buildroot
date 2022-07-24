################################################################################
#
# libglvnd
#
################################################################################

LIBGLVND_VERSION = 1.4.0
LIBGLVND_SITE = https://gitlab.freedesktop.org/glvnd/libglvnd/uploads/ca5bf4295beb39bb324f692c481ac8a1

LIBGLVND_LICENSE = \
	libglvnd license, \
	Apache-2.0 (Khronos headers), \
	MIT (Xorg; mesa; cJSON), \
	BSD-1=Clause (uthash)

LIBGLVND_LICENSE_FILES = \
	README.md \
	src/util/uthash/LICENSE \
	src/util/cJSON/LICENSE

LIBGLVND_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_XLIB_LIBX11),y)
LIBGLVND_DEPENDENCIES += xlib_libX11
LIBGLVND_CONF_OPTS += -Dx11=enabled
else
LIBGLVND_CONF_OPTS += -Dx11=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGLVND_DISPATCH_GL),y)
LIBGLVND_DEPENDENCIES += xlib_libXext xorgproto
LIBGLVND_CONF_OPTS += -Dglx=enabled
LIBGLVND_PROVIDES += libgl
else
LIBGLVND_CONF_OPTS += -Dglx=disabled
endif

ifeq ($(BR2_PACKAGE_LIBGLVND_DISPATCH_EGL),y)
LIBGLVND_CONF_OPTS += -Degl=true
LIBGLVND_PROVIDES += libegl
else
LIBGLVND_CONF_OPTS += -Degl=false
endif

ifeq ($(BR2_PACKAGE_LIBGLVND_DISPATCH_GLES),y)
LIBGLVND_CONF_OPTS += -Dgles1=true -Dgles2=true
LIBGLVND_PROVIDES += libgles
else
LIBGLVND_CONF_OPTS += -Dgles1=false -Dgles2=false
endif

$(eval $(meson-package))
