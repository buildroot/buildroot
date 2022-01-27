################################################################################
#
# lighttpd
#
################################################################################

LIGHTTPD_VERSION_MAJOR = 1.4
LIGHTTPD_VERSION = $(LIGHTTPD_VERSION_MAJOR).64
LIGHTTPD_SOURCE = lighttpd-$(LIGHTTPD_VERSION).tar.xz
LIGHTTPD_SITE = http://download.lighttpd.net/lighttpd/releases-$(LIGHTTPD_VERSION_MAJOR).x
LIGHTTPD_LICENSE = BSD-3-Clause
LIGHTTPD_LICENSE_FILES = COPYING
LIGHTTPD_CPE_ID_VENDOR = lighttpd
LIGHTTPD_DEPENDENCIES = host-pkgconf xxhash
LIGHTTPD_CONF_OPTS = \
	-Dwith_dbi=false \
	-Dwith_fam=false \
	-Dwith_gnutls=false \
	-Dwith_libev=false \
	-Dwith_libunwind=false \
	-Dwith_mbedtls=false \
	-Dwith_mysql=false \
	-Dwith_nettle=false \
	-Dwith_nss=false \
	-Dwith_pcre=false \
	-Dwith_pgsql=false \
	-Dwith_sasl=false \
	-Dwith_wolfssl=false \
	-Dwith_xattr=false \
	-Dwith_xxhash=true \
	-Dbuild_extra_warnings=false \
	-Dbuild_static=false \
	-Dmoduledir=lib/lighttpd

ifeq ($(BR2_PACKAGE_LIGHTTPD_BROTLI),y)
LIGHTTPD_DEPENDENCIES += brotli
LIGHTTPD_CONF_OPTS += -Dwith_brotli=true
else
LIGHTTPD_CONF_OPTS += -Dwith_brotli=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_BZIP2),y)
LIGHTTPD_DEPENDENCIES += bzip2
LIGHTTPD_CONF_OPTS += -Dwith_bzip=true
else
LIGHTTPD_CONF_OPTS += -Dwith_bzip=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_KRB5),y)
LIGHTTPD_DEPENDENCIES += libkrb5
LIGHTTPD_CONF_OPTS += -Dwith_krb5=true
else
LIGHTTPD_CONF_OPTS += -Dwith_krb5=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_LDAP),y)
LIGHTTPD_DEPENDENCIES += openldap
LIGHTTPD_CONF_OPTS += -Dwith_ldap=true
else
LIGHTTPD_CONF_OPTS += -Dwith_ldap=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_LUA),y)
LIGHTTPD_DEPENDENCIES += lua
LIGHTTPD_CONF_OPTS += -Dwith_lua=true
else
LIGHTTPD_CONF_OPTS += -Dwith_lua=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_MAXMINDDB),y)
LIGHTTPD_DEPENDENCIES += libmaxminddb
LIGHTTPD_CONF_OPTS += -Dwith_maxminddb=true
else
LIGHTTPD_CONF_OPTS += -Dwith_maxminddb=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_OPENSSL),y)
LIGHTTPD_DEPENDENCIES += openssl
LIGHTTPD_CONF_OPTS += -Dwith_openssl=true
else
LIGHTTPD_CONF_OPTS += -Dwith_openssl=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_PAM),y)
LIGHTTPD_DEPENDENCIES += linux-pam
LIGHTTPD_CONF_OPTS += -Dwith_pam=true
else
LIGHTTPD_CONF_OPTS += -Dwith_pam=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_PCRE),y)
LIGHTTPD_DEPENDENCIES += pcre2
LIGHTTPD_CONF_OPTS += -Dwith_pcre2=true
else
LIGHTTPD_CONF_OPTS += -Dwith_pcre2=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_WEBDAV),y)
LIGHTTPD_DEPENDENCIES += libxml2 sqlite
LIGHTTPD_CONF_OPTS += -Dwith_webdav_props=true
ifeq ($(BR2_PACKAGE_UTIL_LINUX_LIBUUID),y)
LIGHTTPD_CONF_OPTS += -Dwith_webdav_locks=true
LIGHTTPD_DEPENDENCIES += util-linux
else
LIGHTTPD_CONF_OPTS += -Dwith_webdav_locks=false
endif
else
LIGHTTPD_CONF_OPTS += -Dwith_webdav_props=false -Dwith_webdav_locks=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_ZLIB),y)
LIGHTTPD_DEPENDENCIES += zlib
LIGHTTPD_CONF_OPTS += -Dwith_zlib=true
else
LIGHTTPD_CONF_OPTS += -Dwith_zlib=false
endif

ifeq ($(BR2_PACKAGE_LIGHTTPD_ZSTD),y)
LIGHTTPD_DEPENDENCIES += zstd
LIGHTTPD_CONF_OPTS += -Dwith_zstd=true
else
LIGHTTPD_CONF_OPTS += -Dwith_zstd=false
endif

define LIGHTTPD_INSTALL_CONFIG
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/lighttpd/conf.d
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/var/www
	$(INSTALL) -D -m 0644 $(@D)/doc/config/lighttpd.conf \
		$(TARGET_DIR)/etc/lighttpd/lighttpd.conf
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
