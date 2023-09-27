################################################################################
#
# onevpl
#
################################################################################

ONEVPL_VERSION = 2023.3.1
ONEVPL_SITE = $(call github,oneapi-src,oneVPL,v$(ONEVPL_VERSION))
ONEVPL_LICENSE = MIT
ONEVPL_LICENSE_FILES = LICENSE
ONEVPL_INSTALL_STAGING = YES
ONEVPL_DEPENDENCIES = host-pkgconf

ONEVPL_CONF_OPTS = \
	-DBUILD_TOOLS=OFF \
	-DINSTALL_EXAMPLE_CODE=OFF

ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
ONEVPL_CONF_OPTS += \
	-DCMAKE_CXX_FLAGS="-latomic"
endif

ifeq ($(BR2_PACKAGE_LIBVA),y)
ONEVPL_CONF_OPTS += -DENABLE_VA=ON
ONEVPL_DEPENDENCIES += libva
else
ONEVPL_CONF_OPTS += -DENABLE_VA=OFF
endif

ifeq ($(BR2_PACKAGE_WAYLAND),y)
ONEVPL_CONF_OPTS += -DENABLE_WAYLAND=ON
ONEVPL_DEPENDENCIES += wayland wayland-protocols
else
ONEVPL_CONF_OPTS += -DENABLE_WAYLAND=OFF
endif

ifeq ($(BR2_PACKAGE_XORG7),y)
ONEVPL_CONF_OPTS += -DENABLE_X11=ON
ONEVPL_DEPENDENCIES += libxcb xlib_libX11
else
ONEVPL_CONF_OPTS += -DENABLE_X11=OFF
endif

$(eval $(cmake-package))
