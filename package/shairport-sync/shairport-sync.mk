################################################################################
#
# shairport-sync
#
################################################################################

SHAIRPORT_SYNC_VERSION = 3.3.9
SHAIRPORT_SYNC_SITE = $(call github,mikebrady,shairport-sync,$(SHAIRPORT_SYNC_VERSION))

SHAIRPORT_SYNC_LICENSE = MIT, BSD-3-Clause
SHAIRPORT_SYNC_LICENSE_FILES = LICENSES
SHAIRPORT_SYNC_DEPENDENCIES = alsa-lib libconfig popt host-pkgconf

# git clone, no configure
SHAIRPORT_SYNC_AUTORECONF = YES

SHAIRPORT_SYNC_CONF_OPTS = --with-alsa \
	--with-metadata \
	--with-pipe \
	--with-stdout

SHAIRPORT_SYNC_CONF_ENV += LIBS="$(SHAIRPORT_SYNC_CONF_LIBS)"

# Avahi or tinysvcmdns (shaiport-sync bundles its own version of tinysvcmdns).
ifeq ($(BR2_PACKAGE_AVAHI_LIBAVAHI_CLIENT),y)
SHAIRPORT_SYNC_DEPENDENCIES += avahi
SHAIRPORT_SYNC_CONF_OPTS += --with-avahi --without-tinysvcmdns
else
SHAIRPORT_SYNC_CONF_OPTS += --without-avahi --with-tinysvcmdns
endif

ifeq ($(BR2_PACKAGE_LIBDAEMON),y)
SHAIRPORT_SYNC_DEPENDENCIES += libdaemon
SHAIRPORT_SYNC_CONF_OPTS += --with-libdaemon
else
SHAIRPORT_SYNC_CONF_OPTS += --without-libdaemon
endif

# OpenSSL or mbedTLS
ifeq ($(BR2_PACKAGE_OPENSSL),y)
SHAIRPORT_SYNC_DEPENDENCIES += openssl
SHAIRPORT_SYNC_CONF_OPTS += --with-ssl=openssl
else
SHAIRPORT_SYNC_DEPENDENCIES += mbedtls
SHAIRPORT_SYNC_CONF_OPTS += --with-ssl=mbedtls
SHAIRPORT_SYNC_CONF_LIBS += -lmbedx509 -lmbedcrypto
endif

ifeq ($(BR2_PACKAGE_SHAIRPORT_SYNC_CONVOLUTION),y)
SHAIRPORT_SYNC_DEPENDENCIES += libsndfile
SHAIRPORT_SYNC_CONF_OPTS += --with-convolution
else
SHAIRPORT_SYNC_CONF_OPTS += --without-convolution
endif

ifeq ($(BR2_PACKAGE_SHAIRPORT_SYNC_DBUS),y)
SHAIRPORT_SYNC_DEPENDENCIES += libglib2
SHAIRPORT_SYNC_CONF_OPTS += --with-dbus-interface --with-mpris-interface
define SHAIRPORT_SYNC_INSTALL_DBUS
	$(INSTALL) -m 0644 -D \
		$(@D)/scripts/shairport-sync-dbus-policy.conf \
		$(TARGET_DIR)/etc/dbus-1/system.d/shairport-sync-dbus.conf
	$(INSTALL) -m 0644 -D \
		$(@D)/scripts/shairport-sync-mpris-policy.conf \
		$(TARGET_DIR)/etc/dbus-1/system.d/shairport-sync-mpris.conf
endef
else
SHAIRPORT_SYNC_CONF_OPTS += --without-dbus-interface --without-mpris-interface
endif

ifeq ($(BR2_PACKAGE_SHAIRPORT_SYNC_LIBSOXR),y)
SHAIRPORT_SYNC_DEPENDENCIES += libsoxr
SHAIRPORT_SYNC_CONF_OPTS += --with-soxr
else
SHAIRPORT_SYNC_CONF_OPTS += --without-soxr
endif

ifeq ($(BR2_PACKAGE_SHAIRPORT_SYNC_MQTT),y)
SHAIRPORT_SYNC_DEPENDENCIES += avahi dbus mosquitto
SHAIRPORT_SYNC_CONF_OPTS += --with-mqtt-client
else
SHAIRPORT_SYNC_CONF_OPTS += --without-mqtt-client
endif

define SHAIRPORT_SYNC_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/shairport-sync \
		$(TARGET_DIR)/usr/bin/shairport-sync
	$(INSTALL) -D -m 0644 $(@D)/scripts/shairport-sync.conf \
		$(TARGET_DIR)/etc/shairport-sync.conf
	$(SHAIRPORT_SYNC_INSTALL_DBUS)
endef

define SHAIRPORT_SYNC_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/shairport-sync/S99shairport-sync \
		$(TARGET_DIR)/etc/init.d/S99shairport-sync
endef

$(eval $(autotools-package))
