################################################################################
#
# libglfw
#
################################################################################

LIBGLFW_VERSION = 3.3.8
LIBGLFW_SITE = $(call github,glfw,glfw,$(LIBGLFW_VERSION))
LIBGLFW_INSTALL_STAGING = YES
LIBGLFW_LICENSE = Zlib
LIBGLFW_LICENSE_FILES = LICENSE.md

LIBGLFW_CONF_OPTS += \
	-DGLFW_BUILD_EXAMPLES=OFF \
	-DGLFW_BUILD_TESTS=OFF \
	-DGLFW_BUILD_DOCS=OFF

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBGLFW_DEPENDENCIES += xlib_libXcursor xlib_libXext \
	xlib_libXi xlib_libXinerama xlib_libXrandr
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGL),y)
LIBGLFW_DEPENDENCIES += libgl
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGLES),y)
LIBGLFW_DEPENDENCIES += libgles
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBGLFW_DEPENDENCIES += libxkbcommon wayland-protocols
# Override pkg-config pkgdatadir variable, it needs the prefix
LIBGLFW_CONF_OPTS += \
	-DGLFW_USE_WAYLAND=1 \
	-DWAYLAND_PROTOCOLS_BASE=$(STAGING_DIR)/usr/share/wayland-protocols
endif

ifeq ($(BR2_PACKAGE_XLIB_LIBXXF86VM),y)
LIBGLFW_DEPENDENCIES += xlib_libXxf86vm
endif

$(eval $(cmake-package))
