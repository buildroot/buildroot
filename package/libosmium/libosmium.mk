################################################################################
#
# libosmium
#
################################################################################

LIBOSMIUM_VERSION = 2.17.0
LIBOSMIUM_SITE = $(call github,osmcode,libosmium,v$(LIBOSMIUM_VERSION))
LIBOSMIUM_LICENSE = BSL-1.0
LIBOSMIUM_LICENSE_FILES = LICENSE
LIBOSMIUM_INSTALL_STAGING = YES
LIBOSMIUM_DEPENDENCIES = boost protozero

ifeq ($(BR2_PACKAGE_BZIP2),y)
LIBOSMIUM_DEPENDENCIES += bzip2
endif

ifeq ($(BR2_PACKAGE_EXPAT),y)
LIBOSMIUM_DEPENDENCIES += expat
endif

ifeq ($(BR2_PACKAGE_LIBGEOS),y)
LIBOSMIUM_DEPENDENCIES += libgeos
endif

ifeq ($(BR2_PACKAGE_LZ4),y)
LIBOSMIUM_DEPENDENCIES += lz4
endif

ifeq ($(BR2_PACKAGE_PROJ),y)
LIBOSMIUM_DEPENDENCIES += proj
endif

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBOSMIUM_DEPENDENCIES += zlib
endif

$(eval $(cmake-package))
