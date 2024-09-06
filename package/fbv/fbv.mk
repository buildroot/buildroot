################################################################################
#
# fbv
#
################################################################################

FBV_VERSION = 7c2000804226ca860ca80f3baa993582e29aa1a2
FBV_SITE = $(call github,amadvance,fbv,$(FBV_VERSION))
FBV_LICENSE = GPL-2.0
FBV_LICENSE_FILES = COPYING
FBV_AUTORECONF = YES

### image format dependencies and configure options
FBV_DEPENDENCIES = # empty
FBV_CONFIGURE_OPTS = # empty
ifeq ($(BR2_PACKAGE_FBV_PNG),y)
FBV_DEPENDENCIES += libpng

# libpng in turn depends on other libraries
ifeq ($(BR2_STATIC_LIBS),y)
FBV_CONFIGURE_OPTS += "--libs=`$(PKG_CONFIG_HOST_BINARY) --libs libpng`"
endif

else
FBV_CONFIGURE_OPTS += --without-libpng
endif
ifeq ($(BR2_PACKAGE_FBV_JPEG),y)
FBV_DEPENDENCIES += jpeg
else
FBV_CONFIGURE_OPTS += --without-libjpeg
endif

$(eval $(autotools-package))
