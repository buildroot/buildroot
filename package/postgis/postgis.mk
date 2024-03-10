################################################################################
#
# postgis
#
################################################################################

POSTGIS_VERSION = 3.4.2
POSTGIS_SITE = https://download.osgeo.org/postgis/source
# parallel build issues
POSTGIS_MAKE = $(MAKE1)
POSTGIS_LICENSE = GPL-2.0+ (PostGIS), BSD-3-Clause (xsl), GPL-2.0+ or LGPL-3.0+ (SFCGAL), MIT, Apache-2.0, ISC, BSL-1.0, CC-BY-SA-3.0
POSTGIS_LICENSE_FILES = LICENSE.TXT
POSTGIS_CPE_ID_VENDOR = postgis

POSTGIS_DEPENDENCIES = postgresql libgeos proj libxml2

POSTGIS_CONF_OPTS += \
	--with-pgconfig=$(STAGING_DIR)/usr/bin/pg_config \
	--with-geosconfig=$(STAGING_DIR)/usr/bin/geos-config \
	--with-xml2config=$(STAGING_DIR)/usr/bin/xml2-config

ifeq ($(BR2_PACKAGE_JSON_C),y)
POSTGIS_DEPENDENCIES += json-c
POSTGIS_CONF_OPTS += --with-json
else
POSTGIS_CONF_OPTS += --without-json
endif

ifeq ($(BR2_PACKAGE_GDAL),y)
POSTGIS_DEPENDENCIES += gdal
POSTGIS_CONF_OPTS += --with-raster --with-gdalconfig=$(STAGING_DIR)/usr/bin/gdal-config
else
POSTGIS_CONF_OPTS += --without-raster
endif

ifeq ($(BR2_PACKAGE_PCRE),y)
POSTGIS_DEPENDENCIES += pcre
endif

ifeq ($(BR2_PACKAGE_PROTOBUF_C),y)
POSTGIS_DEPENDENCIES += protobuf-c
POSTGIS_CONF_OPTS += --with-protobuf
else
POSTGIS_CONF_OPTS += --without-protobuf
endif

$(eval $(autotools-package))
