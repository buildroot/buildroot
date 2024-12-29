################################################################################
#
# libvpl
#
################################################################################

LIBVPL_VERSION = 2.14.0
LIBVPL_SITE = $(call github,intel,libvpl,v$(LIBVPL_VERSION))
LIBVPL_LICENSE = MIT
LIBVPL_LICENSE_FILES = LICENSE
LIBVPL_INSTALL_STAGING = YES
LIBVPL_DEPENDENCIES = host-pkgconf

LIBVPL_CONF_OPTS = \
	-DBUILD_TOOLS=OFF \
	-DINSTALL_EXAMPLE_CODE=OFF

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
LIBVPL_CONF_OPTS += \
	-DCMAKE_CXX_FLAGS="-latomic"
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
LIBVPL_CONF_OPTS += -DENABLE_VA=ON
LIBVPL_DEPENDENCIES += libva
else
LIBVPL_CONF_OPTS += -DENABLE_VA=OFF
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBVPL_CONF_OPTS += -DENABLE_WAYLAND=ON
LIBVPL_DEPENDENCIES += wayland wayland-protocols
else
LIBVPL_CONF_OPTS += -DENABLE_WAYLAND=OFF
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
LIBVPL_CONF_OPTS += -DENABLE_X11=ON
LIBVPL_DEPENDENCIES += libxcb xlib_libX11
else
LIBVPL_CONF_OPTS += -DENABLE_X11=OFF
endif

$(eval $(cmake-package))
