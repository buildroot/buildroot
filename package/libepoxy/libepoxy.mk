################################################################################
#
# libepoxy
#
################################################################################

LIBEPOXY_VERSION_MAJOR = 1.4
LIBEPOXY_VERSION = $(LIBEPOXY_VERSION_MAJOR).1
LIBEPOXY_SITE = http://ftp.gnome.org/pub/gnome/sources/libepoxy/$(LIBEPOXY_VERSION_MAJOR)
LIBEPOXY_SOURCE = libepoxy-$(LIBEPOXY_VERSION).tar.xz
LIBEPOXY_INSTALL_STAGING = YES
LIBEPOXY_DEPENDENCIES = host-pkgconf xutil_util-macros
LIBEPOXY_LICENSE = MIT
LIBEPOXY_LICENSE_FILES = COPYING

ifeq ($(BR2_PACKAGE_HAS_LIBEGL),y)
LIBEPOXY_CONF_OPTS += --enable-egl
LIBEPOXY_DEPENDENCIES += libegl
else
LIBEPOXY_CONF_OPTS += --disable-egl
endif

ifeq ($(BR2_PACKAGE_HAS_NEXUS),y)
LIBEPOXY_MAKE_OPTS += \
	CFLAGS='$(TARGET_CFLAGS) \
            -DGLX_LIB_NAME="libv3ddriver.so" \
            -DEGL_LIB_NAME="libv3ddriver.so" \
            -DGLES1_LIB_NAME="libv3ddriver.so" \
            -DGLES2_LIB_NAME="libv3ddriver.so"'
else ifeq ($(BR2_PACKAGE_HORIZON_SDK),y)
LIBEPOXY_CONF_OPTS += \
	CFLAGS='$(TARGET_CFLAGS) \
			-DGLX_LIB_NAME="libGLESv2.so" \
			-DEGL_LIB_NAME="libEGL.so" \
			-DGLES1_LIB_NAME="libGLESv1_CM.so" \
			-DGLES2_LIB_NAME="libGLESv2.so"'
else
LIBEPOXY_MAKE_OPTS += \
	CFLAGS='$(TARGET_CFLAGS) \
            -DGLX_LIB_NAME="libGL.so.1" \
            -DEGL_LIB_NAME="libEGL.so.1" \
            -DGLES1_LIB_NAME="libGLESv1_CM.so.1" \
            -DGLES2_LIB_NAME="libGLESv2.so.2"'
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL)$(BR2_PACKAGE_XLIB_LIBX11),yy)
LIBEPOXY_CONF_OPTS += --enable-glx
LIBEPOXY_DEPENDENCIES += libgl xlib_libX11
else
LIBEPOXY_CONF_OPTS += --disable-glx
endif

$(eval $(autotools-package))
