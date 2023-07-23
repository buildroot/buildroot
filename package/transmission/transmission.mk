################################################################################
#
# transmission
#
################################################################################

TRANSMISSION_VERSION = 4.0.3
TRANSMISSION_SOURCE = transmission-$(TRANSMISSION_VERSION).tar.xz
TRANSMISSION_SITE = https://github.com/transmission/transmission/releases/download/$(TRANSMISSION_VERSION)
TRANSMISSION_DEPENDENCIES = \
	host-pkgconf \
	dht \
	libb64 \
	libcurl \
	libdeflate \
	libevent \
	libminiupnpc \
	libnatpmp \
	libpsl \
	libutp \
	openssl \
	zlib
TRANSMISSION_CONF_OPTS = \
	-DENABLE_TESTS=OFF \
	-DRUN_CLANG_TIDY=OFF \
	-DUSE_SYSTEM_B64=ON \
	-DUSE_SYSTEM_DEFLATE=ON \
	-DUSE_SYSTEM_DHT=ON \
	-DUSE_SYSTEM_NATPMP=ON \
	-DUSE_SYSTEM_PSL=ON \
	-DWITH_INOTIFY=OFF
TRANSMISSION_LICENSE = GPL-2.0 or GPL-3.0 with OpenSSL exception
TRANSMISSION_LICENSE_FILES = COPYING
TRANSMISSION_CPE_ID_VENDOR = transmissionbt

# Uses __atomic_load_8
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
TRANSMISSION_CONF_OPTS += -DCMAKE_EXE_LINKER_FLAGS=-latomic
endif

ifeq ($(BR2_PACKAGE_TRANSMISSION_CLI),y)
TRANSMISSION_CONF_OPTS += -DENABLE_CLI=ON
else
TRANSMISSION_CONF_OPTS += -DENABLE_CLI=OFF
endif

ifeq ($(BR2_PACKAGE_TRANSMISSION_DAEMON),y)
TRANSMISSION_CONF_OPTS += -DENABLE_DAEMON=ON

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
TRANSMISSION_DEPENDENCIES += systemd
TRANSMISSION_CONF_OPTS += -DWITH_SYSTEMD=ON
else
TRANSMISSION_CONF_OPTS += -DWITH_SYSTEMD=OFF
endif

define TRANSMISSION_USERS
	transmission -1 transmission -1 * /var/lib/transmission - transmission Transmission Daemon
endef

define TRANSMISSION_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/transmission/S92transmission \
		$(TARGET_DIR)/etc/init.d/S92transmission
endef

define TRANSMISSION_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/daemon/transmission-daemon.service \
		$(TARGET_DIR)/usr/lib/systemd/system/transmission-daemon.service
endef

else
TRANSMISSION_CONF_OPTS += -DENABLE_DAEMON=OFF
endif

ifeq ($(BR2_PACKAGE_TRANSMISSION_GTK),y)
TRANSMISSION_CONF_OPTS += -DENABLE_GTK=ON
TRANSMISSION_DEPENDENCIES += gtkmm3 libgtk3
else
TRANSMISSION_CONF_OPTS += -DENABLE_GTK=OFF
endif

$(eval $(cmake-package))
