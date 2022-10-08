################################################################################
#
# lrzip
#
################################################################################

LRZIP_VERSION = 0.641
LRZIP_SITE = $(call github,ckolivas,lrzip,v$(LRZIP_VERSION))
LRZIP_AUTORECONF = YES
LRZIP_LICENSE = GPL-2.0+
LRZIP_LICENSE_FILES = COPYING
LRZIP_CPE_ID_VENDOR = long_range_zip_project
LRZIP_CPE_ID_PRODUCT = long_range_zip
LRZIP_DEPENDENCIES = zlib lz4 lzo bzip2

ifeq ($(BR2_i386)$(BR2_x86_64),y)
LRZIP_DEPENDENCIES += host-nasm
LRZIP_CONF_OPTS += --enable-asm
else
LRZIP_CONF_OPTS += --disable-asm
endif

$(eval $(autotools-package))
