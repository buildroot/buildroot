################################################################################
#
# libgeotiff
#
################################################################################

LIBGEOTIFF_VERSION = 1.7.3
LIBGEOTIFF_SITE = http://download.osgeo.org/geotiff/libgeotiff
LIBGEOTIFF_LICENSE = MIT, public domain
LIBGEOTIFF_LICENSE_FILES = LICENSE
LIBGEOTIFF_DEPENDENCIES = proj tiff host-pkgconf
LIBGEOTIFF_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_ZLIB),y)
LIBGEOTIFF_DEPENDENCIES += zlib
LIBGEOTIFF_CONF_OPTS += --with-zlib
else
LIBGEOTIFF_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_JPEG),y)
LIBGEOTIFF_DEPENDENCIES += jpeg
LIBGEOTIFF_CONF_OPTS += --with-jpeg
else
LIBGEOTIFF_CONF_OPTS += --without-jpeg
endif

$(eval $(autotools-package))
