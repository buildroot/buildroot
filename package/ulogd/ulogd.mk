################################################################################
#
# ulogd
#
################################################################################

ULOGD_VERSION = 2.0.8
ULOGD_SOURCE = ulogd-$(ULOGD_VERSION).tar.bz2
ULOGD_SITE = http://www.netfilter.org/projects/ulogd/files
ULOGD_DEPENDENCIES = host-pkgconf \
	libmnl libnetfilter_acct libnetfilter_conntrack libnetfilter_log \
	libnfnetlink
ULOGD_LICENSE = GPL-2.0
ULOGD_LICENSE_FILES = COPYING
ULOGD_SELINUX_MODULES = ulogd

# DB backends need threads
ifeq ($(BR2_TOOLCHAIN_HAS_THREADS),y)
ifeq ($(BR2_PACKAGE_LIBDBI),y)
ULOGD_CONF_OPTS += --enable-dbi
ULOGD_DEPENDENCIES += libdbi
else
ULOGD_CONF_OPTS += --disable-dbi
endif
ifeq ($(BR2_PACKAGE_MARIADB),y)
ULOGD_CONF_OPTS += \
	--enable-mysql \
	--with-mysql-config=$(STAGING_DIR)/usr/bin/mysql_config
ULOGD_DEPENDENCIES += mariadb
else
ULOGD_CONF_OPTS += --disable-mysql
endif
ifeq ($(BR2_PACKAGE_POSTGRESQL),y)
ULOGD_CONF_OPTS += --enable-pgsql
ULOGD_DEPENDENCIES += postgresql
else
ULOGD_CONF_OPTS += --disable-pgsql
endif
ifeq ($(BR2_PACKAGE_SQLITE),y)
ULOGD_CONF_OPTS += --enable-sqlite3
ULOGD_DEPENDENCIES += sqlite
else
ULOGD_CONF_OPTS += --disable-sqlite3
endif
else
ULOGD_CONF_OPTS += \
	--disable-dbi \
	--disable-mysql \
	--disable-pgsql \
	--disable-sqlite3
endif

ifeq ($(BR2_PACKAGE_LIBPCAP),y)
ULOGD_CONF_OPTS += --enable-pcap
ULOGD_DEPENDENCIES += libpcap
else
ULOGD_CONF_OPTS += --disable-pcap
endif

ifeq ($(BR2_PACKAGE_JANSSON),y)
ULOGD_CONF_OPTS += --enable-json
ULOGD_DEPENDENCIES += jansson
else
ULOGD_CONF_OPTS += --disable-json
endif

$(eval $(autotools-package))
