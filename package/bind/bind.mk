################################################################################
#
# bind
#
################################################################################

BIND_VERSION = 9.18.41
BIND_SOURCE= bind-$(BIND_VERSION).tar.xz
BIND_SITE = https://ftp.isc.org/isc/bind9/$(BIND_VERSION)
BIND_INSTALL_STAGING = YES
BIND_LICENSE = MPL-2.0
BIND_LICENSE_FILES = COPYRIGHT
BIND_CPE_ID_VENDOR = isc
BIND_SELINUX_MODULES = bind
# Library CVE and not used by bind but used by ISC DHCP
BIND_IGNORE_CVES += CVE-2019-6470
BIND_TARGET_SERVER_SBIN = arpaname ddns-confgen dnssec-checkds dnssec-coverage
BIND_TARGET_SERVER_SBIN += dnssec-importkey dnssec-keygen dnssec-revoke
BIND_TARGET_SERVER_SBIN += dnssec-settime dnssec-verify genrandom
BIND_TARGET_SERVER_SBIN += isc-hmac-fixup named-journalprint nsec3hash
BIND_TARGET_SERVER_SBIN += lwresd named named-checkconf named-checkzone
BIND_TARGET_SERVER_SBIN += named-compilezone rndc rndc-confgen dnssec-dsfromkey
BIND_TARGET_SERVER_SBIN += dnssec-keyfromlabel dnssec-signzone tsig-keygen
BIND_TARGET_TOOLS_BIN = dig host nslookup nsupdate
# avoid potential Debian 12 libtool 2.4.7 bug
# https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=929396
BIND_AUTORECONF = YES
BIND_CONF_OPTS = \
	--without-cmocka \
	--without-lmdb \
	--disable-doh \
	--disable-static \
	--with-openssl=$(STAGING_DIR)/usr

BIND_DEPENDENCIES = host-pkgconf libuv openssl

BIND_CFLAGS = $(TARGET_CFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_101737),y)
BIND_CFLAGS += -O0
endif

BIND_CONF_OPTS += CFLAGS="$(BIND_CFLAGS)"

ifeq ($(BR2_PACKAGE_ZLIB),y)
BIND_CONF_OPTS += --with-zlib
BIND_DEPENDENCIES += zlib
else
BIND_CONF_OPTS += --without-zlib
endif

ifeq ($(BR2_PACKAGE_JEMALLOC),y)
BIND_CONF_OPTS += --with-jemalloc
BIND_DEPENDENCIES += jemalloc
else
BIND_CONF_OPTS += --without-jemalloc
endif

ifeq ($(BR2_PACKAGE_JSON_C),y)
BIND_CONF_OPTS += --with-json-c
BIND_DEPENDENCIES += json-c
else
BIND_CONF_OPTS += --without-json-c
endif

ifeq ($(BR2_PACKAGE_LIBCAP),y)
BIND_CONF_OPTS += --enable-linux-caps
BIND_DEPENDENCIES += libcap
else
BIND_CONF_OPTS += --disable-linux-caps
endif

ifeq ($(BR2_PACKAGE_LIBIDN2),y)
BIND_CONF_OPTS += --with-libidn2
BIND_DEPENDENCIES += libidn2
else
BIND_CONF_OPTS += --without-libidn2
endif

ifeq ($(BR2_PACKAGE_LIBKRB5),y)
BIND_CONF_OPTS += --with-gssapi=$(STAGING_DIR)/usr/bin/krb5-config
BIND_DEPENDENCIES += libkrb5
else
BIND_CONF_OPTS += --with-gssapi=no
endif

ifeq ($(BR2_PACKAGE_LIBMAXMINDDB),y)
BIND_CONF_OPTS += --enable-geoip --with-maxminddb
BIND_DEPENDENCIES += libmaxminddb
else
BIND_CONF_OPTS += --disable-geoip
endif

ifeq ($(BR2_PACKAGE_LIBXML2),y)
BIND_CONF_OPTS += --with-libxml2
BIND_DEPENDENCIES += libxml2
else
BIND_CONF_OPTS += --with-libxml2=no
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
BIND_DEPENDENCIES += readline
else
BIND_CONF_OPTS += --with-readline=no
endif

define BIND_TARGET_REMOVE_SERVER
	rm -rf $(addprefix $(TARGET_DIR)/usr/sbin/, $(BIND_TARGET_SERVER_SBIN))
endef

define BIND_TARGET_REMOVE_TOOLS
	rm -rf $(addprefix $(TARGET_DIR)/usr/bin/, $(BIND_TARGET_TOOLS_BIN))
endef

ifeq ($(BR2_PACKAGE_BIND_SERVER),y)
define BIND_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(BIND_PKGDIR)/S81named \
		$(TARGET_DIR)/etc/init.d/S81named
endef
define BIND_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(BIND_PKGDIR)/named.service \
		$(TARGET_DIR)/usr/lib/systemd/system/named.service
endef
else
BIND_POST_INSTALL_TARGET_HOOKS += BIND_TARGET_REMOVE_SERVER
endif

ifeq ($(BR2_PACKAGE_BIND_TOOLS),)
BIND_POST_INSTALL_TARGET_HOOKS += BIND_TARGET_REMOVE_TOOLS
endif

define BIND_USERS
	named -1 named -1 * /etc/bind - - BIND daemon
endef

$(eval $(autotools-package))
