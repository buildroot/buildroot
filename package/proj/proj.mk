################################################################################
#
# proj
#
################################################################################

PROJ_VERSION = 9.3.0
PROJ_SITE = http://download.osgeo.org/proj
PROJ_LICENSE = MIT
PROJ_LICENSE_FILES = COPYING
PROJ_INSTALL_STAGING = YES
PROJ_DEPENDENCIES = host-pkgconf host-sqlite sqlite

PROJ_CFLAGS = $(TARGET_CFLAGS)
PROJ_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_68485),y)
PROJ_CFLAGS += -O0
PROJ_CXXFLAGS += -O0
endif

PROJ_CONF_OPTS = \
	-DBUILD_APPS=OFF \
	-DCMAKE_C_FLAGS="$(PROJ_CFLAGS)" \
	-DCMAKE_CXX_FLAGS="$(PROJ_CXXFLAGS)"

ifeq ($(BR2_PACKAGE_LIBCURL),y)
PROJ_DEPENDENCIES += libcurl
PROJ_CONF_OPTS += -DENABLE_CURL=ON
else
PROJ_CONF_OPTS += -DENABLE_CURL=OFF
endif

ifeq ($(BR2_PACKAGE_TIFF),y)
PROJ_DEPENDENCIES += tiff
PROJ_CONF_OPTS += -DENABLE_TIFF=ON
else
PROJ_CONF_OPTS += -DENABLE_TIFF=OFF
endif

$(eval $(cmake-package))
