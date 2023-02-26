################################################################################
#
# tiff
#
################################################################################

TIFF_VERSION = 4.5.0
TIFF_SITE = http://download.osgeo.org/libtiff
TIFF_LICENSE = tiff license
TIFF_LICENSE_FILES = LICENSE.md
TIFF_CPE_ID_VENDOR = libtiff
TIFF_CPE_ID_PRODUCT = libtiff
TIFF_INSTALL_STAGING = YES

# 0001-tiffcrop-Correct-simple-copy-paste-error-Fix-488.patch
TIFF_IGNORE_CVES += CVE-2022-48281

# webp has a (optional) dependency on tiff, so we can't have webp
# support in tiff, or that would create a circular dependency.
TIFF_CONF_OPTS = \
	--disable-contrib \
	--disable-tests \
	--disable-webp \
	--without-x

TIFF_DEPENDENCIES = host-pkgconf

HOST_TIFF_CONF_OPTS = \
	--disable-cxx \
	--without-x \
	--disable-zlib \
	--disable-libdeflate \
	--disable-lzma \
	--disable-jpeg \
	--disable-tests \
	--disable-webp \
	--disable-zstd
HOST_TIFF_DEPENDENCIES = host-pkgconf

ifeq ($(BR2_INSTALL_LIBSTDCPP),y)
TIFF_CONF_OPTS += --enable-cxx
else
TIFF_CONF_OPTS += --disable-cxx
endif

ifneq ($(BR2_PACKAGE_TIFF_CCITT),y)
TIFF_CONF_OPTS += --disable-ccitt
endif

ifeq ($(BR2_PACKAGE_TIFF_LIBDEFLATE),y)
TIFF_CONF_OPTS += --enable-libdeflate
TIFF_DEPENDENCIES += libdeflate
else
TIFF_CONF_OPTS += --disable-libdeflate
endif

ifneq ($(BR2_PACKAGE_TIFF_PACKBITS),y)
TIFF_CONF_OPTS += --disable-packbits
endif

ifneq ($(BR2_PACKAGE_TIFF_LZW),y)
TIFF_CONF_OPTS += --disable-lzw
endif

ifneq ($(BR2_PACKAGE_TIFF_THUNDER),y)
TIFF_CONF_OPTS += --disable-thunder
endif

ifneq ($(BR2_PACKAGE_TIFF_NEXT),y)
TIFF_CONF_OPTS += --disable-next
endif

ifneq ($(BR2_PACKAGE_TIFF_LOGLUV),y)
TIFF_CONF_OPTS += --disable-logluv
endif

ifneq ($(BR2_PACKAGE_TIFF_MDI),y)
TIFF_CONF_OPTS += --disable-mdi
endif

ifneq ($(BR2_PACKAGE_TIFF_ZLIB),y)
TIFF_CONF_OPTS += --disable-zlib
else
TIFF_DEPENDENCIES += zlib
endif

ifneq ($(BR2_PACKAGE_TIFF_XZ),y)
TIFF_CONF_OPTS += --disable-lzma
else
TIFF_DEPENDENCIES += xz
endif

ifneq ($(BR2_PACKAGE_TIFF_PIXARLOG),y)
TIFF_CONF_OPTS += --disable-pixarlog
endif

ifneq ($(BR2_PACKAGE_TIFF_JPEG),y)
TIFF_CONF_OPTS += --disable-jpeg
else
TIFF_DEPENDENCIES += jpeg
endif

ifneq ($(BR2_PACKAGE_TIFF_OLD_JPEG),y)
TIFF_CONF_OPTS += --disable-old-jpeg
endif

ifneq ($(BR2_PACKAGE_TIFF_JBIG),y)
TIFF_CONF_OPTS += --disable-jbig
endif

ifeq ($(BR2_PACKAGE_TIFF_UTILITIES),y)
TIFF_CONF_OPTS += --enable-tools
else
TIFF_CONF_OPTS += --disable-tools
endif

ifeq ($(BR2_PACKAGE_TIFF_ZSTD),y)
TIFF_CONF_OPTS += --enable-zstd
TIFF_DEPENDENCIES += zstd
else
TIFF_CONF_OPTS += --disable-zstd
endif

$(eval $(autotools-package))
$(eval $(host-autotools-package))
