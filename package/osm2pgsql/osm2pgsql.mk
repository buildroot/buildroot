################################################################################
#
# osm2pgsql
#
################################################################################

OSM2PGSQL_VERSION = 2.0.1
OSM2PGSQL_SITE = $(call github,osm2pgsql-dev,osm2pgsql,$(OSM2PGSQL_VERSION))
OSM2PGSQL_LICENSE = GPL-2.0+
OSM2PGSQL_LICENSE_FILES = COPYING
OSM2PGSQL_SUPPORTS_IN_SOURCE_BUILD = NO

OSM2PGSQL_DEPENDENCIES = boost bzip2 expat json-for-modern-cpp libosmium postgresql protozero zlib

# fmt > 8.0 is not yet supported
OSM2PGSQL_CONF_OPTS = \
	-DBUILD_TESTS=OFF \
	-DBUILD_COVERAGE=OFF \
	-DEXTERNAL_FMT=OFF \
	-DEXTERNAL_LIBOSMIUM=ON \
	-DEXTERNAL_PROTOZERO=ON

ifeq ($(BR2_PACKAGE_LUAJIT),y)
OSM2PGSQL_DEPENDENCIES += luajit
OSM2PGSQL_CONF_OPTS += -DWITH_LUAJIT=ON
else
OSM2PGSQL_DEPENDENCIES += lua
OSM2PGSQL_CONF_OPTS += -DWITH_LUAJIT=OFF
endif

ifeq ($(BR2_PACKAGE_PROJ),y)
OSM2PGSQL_DEPENDENCIES += proj
OSM2PGSQL_CONF_OPTS += -DWITH_PROJ=ON
else
OSM2PGSQL_CONF_OPTS += -DWITH_PROJ=OFF
endif

$(eval $(cmake-package))
