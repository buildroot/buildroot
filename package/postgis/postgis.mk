################################################################################
#
# postgis
#
################################################################################

POSTGIS_VERSION = 3.1.3
POSTGIS_SITE = https://download.osgeo.org/postgis/source
# parallel build issues
POSTGIS_MAKE = $(MAKE1)
POSTGIS_LICENSE = GPL-2.0+ (PostGIS), BSD-2-Clause, MIT, Apache-2.0, ISC, BSL-1.0, CC-BY-SA-3.0
POSTGIS_LICENSE_FILES = LICENSE.TXT
POSTGIS_CPE_ID_VENDOR = postgis
# configure.ac is patched so need to run autoreconf
POSTGIS_AUTORECONF = YES

POSTGIS_DEPENDENCIES = postgresql libgeos proj libxml2

POSTGIS_CONF_OPTS += \
	--with-pgconfig=$(STAGING_DIR)/usr/bin/pg_config \
	--with-geosconfig=$(STAGING_DIR)/usr/bin/geos-config \
	--with-xml2config=$(STAGING_DIR)/usr/bin/xml2-config

ifeq ($(BR2_PACKAGE_LIBGDAL),y)
POSTGIS_DEPENDENCIES += libgdal
POSTGIS_CONF_OPTS += --with-raster
else
POSTGIS_CONF_OPTS += --without-raster
endif

ifeq ($(BR2_PACKAGE_JSON_C),y)
POSTGIS_DEPENDENCIES += json-c
POSTGIS_CONF_OPTS += --with-json
else
POSTGIS_CONF_OPTS += --without-json
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
