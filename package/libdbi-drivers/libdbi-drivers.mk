################################################################################
#
# libdbi-drivers
#
################################################################################

LIBDBI_DRIVERS_VERSION = 0bfae6c43134cf58dc89364328545982ca297abb
LIBDBI_DRIVERS_SITE = https://git.code.sf.net/p/libdbi-drivers/libdbi-drivers
LIBDBI_DRIVERS_SITE_METHOD = git
LIBDBI_DRIVERS_LICENSE = LGPL-2.1+
LIBDBI_DRIVERS_LICENSE_FILES = COPYING
LIBDBI_DRIVERS_INSTALL_STAGING = YES
LIBDBI_DRIVERS_DEPENDENCIES = libdbi host-pkgconf
LIBDBI_DRIVERS_AUTORECONF = YES

LIBDBI_DRIVERS_CONF_OPTS = --with-dbi-libdir=$(STAGING_DIR)/usr/lib

ifeq ($(BR2_PACKAGE_MYSQL),y)
LIBDBI_DRIVERS_DEPENDENCIES += mysql
LIBDBI_DRIVERS_CONF_OPTS += --with-mysql
LIBDBI_DRIVERS_CONF_ENV += MYSQL_CONFIG="$(STAGING_DIR)/usr/bin/mysql_config"
else
LIBDBI_DRIVERS_CONF_OPTS += --without-mysql
endif

ifeq ($(BR2_PACKAGE_POSTGRESQL),y)
LIBDBI_DRIVERS_DEPENDENCIES += postgresql
LIBDBI_DRIVERS_CONF_OPTS += --with-pgsql
else
LIBDBI_DRIVERS_CONF_OPTS += --without-pgsql
endif

LIBDBI_DRIVERS_CONF_OPTS += --without-sqlite
ifeq ($(BR2_PACKAGE_SQLITE),y)
LIBDBI_DRIVERS_DEPENDENCIES += sqlite
LIBDBI_DRIVERS_CONF_OPTS += --with-sqlite3
else
LIBDBI_DRIVERS_CONF_OPTS += --without-sqlite3
endif

LIBDBI_DRIVERS_CONF_OPTS += --without-msql 	# MiniSQL
LIBDBI_DRIVERS_CONF_OPTS += --without-oracle	# Oracle OCI
LIBDBI_DRIVERS_CONF_OPTS += --without-firebird	# Firebird/Interbase
LIBDBI_DRIVERS_CONF_OPTS += --without-freetds	# Freetds
LIBDBI_DRIVERS_CONF_OPTS += --without-ingres	# Ingres
LIBDBI_DRIVERS_CONF_OPTS += --without-db2	# IBM DB2

$(eval $(autotools-package))
