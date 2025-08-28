################################################################################
#
# unbound
#
################################################################################

UNBOUND_VERSION = 1.21.1
UNBOUND_SITE = https://nlnetlabs.nl/downloads/unbound
UNBOUND_INSTALL_STAGING = YES
UNBOUND_DEPENDENCIES = host-pkgconf expat libevent openssl
UNBOUND_LICENSE = BSD-3-Clause
UNBOUND_LICENSE_FILES = LICENSE
UNBOUND_CPE_ID_VENDOR = nlnetlabs
UNBOUND_CONF_OPTS = \
	--disable-rpath \
	--disable-debug \
	--with-conf-file=/etc/unbound/unbound.conf \
	--with-pidfile=/var/run/unbound.pid \
	--with-rootkey-file=/etc/unbound/root.key \
	--enable-tfo-server \
	--enable-tfo-client \
	--with-libevent=$(STAGING_DIR)/usr \
	--with-libexpat=$(STAGING_DIR)/usr \
	--with-ssl=$(STAGING_DIR)/usr

# Only vulnerable if built with --enable-subnet
UNBOUND_IGNORE_CVES += CVE-2025-5994

ifeq ($(BR2_TOOLCHAIN_HAS_THREADS_NPTL),y)
UNBOUND_CONF_OPTS += --with-pthreads
else
UNBOUND_CONF_OPTS += --without-pthreads
endif

ifeq ($(BR2_ENABLE_LTO),y)
UNBOUND_CONF_OPTS += --enable-flto
else
UNBOUND_CONF_OPTS += --disable-flto
endif

ifeq ($(BR2_PACKAGE_UNBOUND_DNSCRYPT),y)
UNBOUND_CONF_OPTS += --enable-dnscrypt
UNBOUND_DEPENDENCIES += libsodium
else
UNBOUND_CONF_OPTS += --disable-dnscrypt
endif

define UNBOUND_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 755 package/unbound/S70unbound \
		$(TARGET_DIR)/etc/init.d/S70unbound
endef

define UNBOUND_USERS
	unbound -1 unbound -1 * /etc/unbound - - unbound daemon
endef

$(eval $(autotools-package))
