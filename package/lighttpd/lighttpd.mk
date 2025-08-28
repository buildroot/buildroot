################################################################################
#
# lighttpd
#
################################################################################

LIGHTTPD_VERSION_MAJOR = 1.4
LIGHTTPD_VERSION = $(LIGHTTPD_VERSION_MAJOR).81
LIGHTTPD_SOURCE = lighttpd-$(LIGHTTPD_VERSION).tar.xz
LIGHTTPD_SITE = http://download.lighttpd.net/lighttpd/releases-$(LIGHTTPD_VERSION_MAJOR).x
LIGHTTPD_LICENSE = BSD-3-Clause
LIGHTTPD_LICENSE_FILES = COPYING
LIGHTTPD_CPE_ID_VENDOR = lighttpd
LIGHTTPD_DEPENDENCIES = host-pkgconf xxhash
LIGHTTPD_CONF_OPTS = \
	-Dwith_fam=disabled \
	-Dwith_nss=false \
	-Dwith_pcre=disabled \
	-Dwith_sasl=disabled \
	-Dwith_xattr=false \
	-Dwith_xxhash=enabled \
	-Dbuild_extra_warnings=false \
	-Dbuild_static=false \
	-Dmoduledir=lib/lighttpd

ifeq ($(BR2_PACKAGE_LIBXCRYPT),y)
LIGHTTPD_DEPENDENCIES += libxcrypt
endif

ifeq ($(BR2_PACKAGE_LIBUNWIND),y)
LIGHTTPD_DEPENDENCIES += libunwind
LIGHTTPD_CONF_OPTS += -Dwith_libunwind=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_libunwind=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_BROTLI),y)
LIGHTTPD_DEPENDENCIES += brotli
LIGHTTPD_CONF_OPTS += -Dwith_brotli=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_brotli=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_BZIP2),y)
LIGHTTPD_DEPENDENCIES += bzip2
LIGHTTPD_CONF_OPTS += -Dwith_bzip=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_bzip=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_DBI),y)
LIGHTTPD_DEPENDENCIES += libdbi
LIGHTTPD_CONF_OPTS += -Dwith_dbi=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_dbi=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_GNUTLS),y)
LIGHTTPD_DEPENDENCIES += gnutls
LIGHTTPD_CONF_OPTS += -Dwith_gnutls=true
else
LIGHTTPD_CONF_OPTS += -Dwith_gnutls=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_KRB5),y)
LIGHTTPD_DEPENDENCIES += libkrb5
LIGHTTPD_CONF_OPTS += -Dwith_krb5=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_krb5=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_LDAP),y)
LIGHTTPD_DEPENDENCIES += openldap
LIGHTTPD_CONF_OPTS += -Dwith_ldap=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_ldap=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_LUA),y)
LIGHTTPD_DEPENDENCIES += lua
LIGHTTPD_CONF_OPTS += -Dwith_lua=true
else
LIGHTTPD_CONF_OPTS += -Dwith_lua=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_MAXMINDDB),y)
LIGHTTPD_DEPENDENCIES += libmaxminddb
LIGHTTPD_CONF_OPTS += -Dwith_maxminddb=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_maxminddb=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_MBEDTLS),y)
LIGHTTPD_DEPENDENCIES += mbedtls
LIGHTTPD_CONF_OPTS += -Dwith_mbedtls=true
else
LIGHTTPD_CONF_OPTS += -Dwith_mbedtls=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_MYSQL),y)
LIGHTTPD_DEPENDENCIES += mariadb
LIGHTTPD_CONF_OPTS += -Dwith_mysql=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_mysql=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_NETTLE),y)
LIGHTTPD_DEPENDENCIES += nettle
LIGHTTPD_CONF_OPTS += -Dwith_nettle=true
else
LIGHTTPD_CONF_OPTS += -Dwith_nettle=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_OPENSSL),y)
LIGHTTPD_DEPENDENCIES += openssl
LIGHTTPD_CONF_OPTS += -Dwith_openssl=true
else
LIGHTTPD_CONF_OPTS += -Dwith_openssl=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_PAM),y)
LIGHTTPD_DEPENDENCIES += linux-pam
LIGHTTPD_CONF_OPTS += -Dwith_pam=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_pam=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_PCRE),y)
LIGHTTPD_DEPENDENCIES += pcre2
LIGHTTPD_CONF_OPTS += -Dwith_pcre2=true
else
LIGHTTPD_CONF_OPTS += -Dwith_pcre2=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_PGSQL),y)
LIGHTTPD_DEPENDENCIES += postgresql
LIGHTTPD_CONF_OPTS += -Dwith_pgsql=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_pgsql=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_WEBDAV),y)
LIGHTTPD_DEPENDENCIES += libxml2 sqlite
LIGHTTPD_CONF_OPTS += -Dwith_webdav_props=enabled
ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBUUID),y)
LIGHTTPD_CONF_OPTS += -Dwith_webdav_locks=enabled
LIGHTTPD_DEPENDENCIES += util-linux
else
LIGHTTPD_CONF_OPTS += -Dwith_webdav_locks=disabled
endif
else
LIGHTTPD_CONF_OPTS += -Dwith_webdav_props=disabled -Dwith_webdav_locks=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_WOLFSSL),y)
LIGHTTPD_DEPENDENCIES += wolfssl
LIGHTTPD_CONF_OPTS += -Dwith_wolfssl=true
else
LIGHTTPD_CONF_OPTS += -Dwith_wolfssl=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_ZLIB),y)
LIGHTTPD_DEPENDENCIES += zlib
LIGHTTPD_CONF_OPTS += -Dwith_zlib=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_zlib=disabled
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_ZSTD),y)
LIGHTTPD_DEPENDENCIES += zstd
LIGHTTPD_CONF_OPTS += -Dwith_zstd=enabled
else
LIGHTTPD_CONF_OPTS += -Dwith_zstd=disabled
endif

define LIGHTTPD_INSTALL_CONFIG
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/lighttpd/conf.d
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/www
	$(INSTALL) -D -m 0644 $(@D)/doc/config/lighttpd.conf \
		$(TARGET_DIR)/etc/lighttpd/lighttpd.conf
	$(INSTALL) -D -m 0644 $(@D)/doc/config/lighttpd.annotated.conf \
		$(TARGET_DIR)/etc/lighttpd/lighttpd.annotated.conf
	$(INSTALL) -D -m 0644 $(@D)/doc/config/modules.conf \
		$(TARGET_DIR)/etc/lighttpd/modules.conf
	$(INSTALL) -D -m 0644 $(@D)/doc/config/conf.d/access_log.conf \
		$(TARGET_DIR)/etc/lighttpd/conf.d/access_log.conf
	$(INSTALL) -D -m 0644 $(@D)/doc/config/conf.d/debug.conf \
		$(TARGET_DIR)/etc/lighttpd/conf.d/debug.conf
	$(INSTALL) -D -m 0644 $(@D)/doc/config/conf.d/dirlisting.conf \
		$(TARGET_DIR)/etc/lighttpd/conf.d/dirlisting.conf
	$(INSTALL) -D -m 0644 $(@D)/doc/config/conf.d/mime.conf \
		$(TARGET_DIR)/etc/lighttpd/conf.d/mime.conf
endef

LIGHTTPD_POST_INSTALL_TARGET_HOOKS += LIGHTTPD_INSTALL_CONFIG

define LIGHTTPD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/lighttpd/S50lighttpd \
		$(TARGET_DIR)/etc/init.d/S50lighttpd
endef

define LIGHTTPD_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/doc/systemd/lighttpd.service \
		$(TARGET_DIR)/usr/lib/systemd/system/lighttpd.service
	$(INSTALL) -D -m 644 package/lighttpd/lighttpd_tmpfiles.conf \
		$(TARGET_DIR)/usr/lib/tmpfiles.d/lighttpd.conf
endef

$(eval $(meson-package))
