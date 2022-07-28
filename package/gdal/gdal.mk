################################################################################
#
# gdal
#
################################################################################

GDAL_VERSION = 3.5.1
GDAL_SITE = https://download.osgeo.org/gdal/$(GDAL_VERSION)
GDAL_SOURCE = gdal-$(GDAL_VERSION).tar.xz
GDAL_LICENSE = MIT, many others
GDAL_LICENSE_FILES = LICENSE.TXT
GDAL_CPE_ID_VENDOR = osgeo
GDAL_INSTALL_STAGING = YES
GDAL_CONFIG_SCRIPTS = gdal-config
# gdal at its core only needs host-pkgconf, libgeotiff, proj and tiff
# but since by default mrf driver support is enabled, it also needs
# jpeg, libpng and zlib. By default there are also many other drivers
# enabled but it seems, in contrast to mrf driver support, that they
# can be implicitly disabled, by configuring gdal without their
# respectively needed dependencies.
GDAL_DEPENDENCIES = host-pkgconf jpeg json-c libgeotiff libpng proj tiff zlib

# Yes, even though they have --with options, these few libraries are
# mandatory. If we don't provide them, bundled versions are used.
GDAL_CONF_OPTS = \
	--with-geotiff \
	--with-jpeg \
	--with-libjson-c=$(STAGING_DIR)/usr \
	--with-libtool \
	--with-libz \
	--with-png \
	--with-proj \
	--without-armadillo \
	--without-blosc \
	--without-brunsli \
	--without-cfitsio \
	--without-crypto \
	--without-cryptopp \
	--without-curl \
	--without-dds \
	--without-ecw \
	--without-expat \
	--without-exr \
	--without-fgdb \
	--without-freexl \
	--without-geos \
	--without-gnm \
	--without-libkml \
	--without-lz4 \
	--without-gta \
	--without-hdf4 \
	--without-hdf5 \
	--without-hdfs \
	--without-heif \
	--without-idb \
	--without-jp2lura \
	--without-java \
	--without-jpeg12 \
	--without-jxl \
	--without-kakadu \
	--without-kea \
	--without-lerc \
	--without-gif \
	--without-liblzma \
	--without-libdeflate \
	--without-mongocxxv3 \
	--without-mrsid \
	--without-jp2mrsid \
	--without-macosx-framework \
	--without-msg \
	--without-mysql \
	--without-netcdf \
	--without-null \
	--without-oci \
	--without-odbc \
	--without-ogdi \
	--without-opencl \
	--without-openjpeg \
	--without-pam \
	--without-pcidsk \
	--without-pcraster \
	--without-pcre \
	--without-pcre2 \
	--without-pdfium \
	--without-podofo \
	--without-poppler \
	--without-python \
	--without-qhull \
	--without-rasdaman \
	--without-rasterlite2 \
	--without-rdb \
	--without-sfcgal \
	--without-sosi \
	--without-spatialite \
	--without-sqlite3 \
	--without-teigha \
	--without-tiledb \
	--without-webp \
	--without-xerces \
	--without-zstd

ifeq ($(BR2_PACKAGE_LIBXML2),y)
GDAL_DEPENDENCIES += libxml2
GDAL_CONF_OPTS += --with-xml2
else
GDAL_CONF_OPTS += --without-xml2
endif

ifeq ($(BR2_PACKAGE_POSTGRESQL),y)
GDAL_DEPENDENCIES += postgresql
GDAL_CONF_OPTS += --with-pg
else
GDAL_CONF_OPTS += --without-pg
endif

$(eval $(autotools-package))
