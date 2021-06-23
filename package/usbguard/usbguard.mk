################################################################################
#
## usbguard
#
################################################################################

USBGUARD_VERSION = 1.0.0
USBGUARD_SITE = https://github.com/USBGuard/usbguard/releases/download/usbguard-$(USBGUARD_VERSION)
USBGUARD_LICENSE = GPL-2.0+
USBGUARD_LICENSE_FILES = LICENSE
USBGUARD_CONF_OPTS = \
	--with-bundled-catch \
	--with-bundled-pegtl \
	--disable-debug-build \
	--without-dbus \
	--without-polkit \
	--disable-umockdev

USBGUARD_DEPENDENCIES += libqb protobuf

ifeq ($(BR2_PACKAGE_LIBOPENSSL),y)
USBGUARD_CONF_OPTS += --with-crypto-library=openssl
USBGUARD_DEPENDENCIES += libopenssl
endif

ifeq ($(BR2_PACKAGE_LIBGCRYPT),y)
USBGUARD_CONF_ENV += \
	ac_cv_path_LIBGCRYPT_CONFIG=$(STAGING_DIR)/usr/bin/libgcrypt-config
USBGUARD_CONF_OPTS += --with-crypto-library=gcrypt
USBGUARD_DEPENDENCIES += libgcrypt
endif

ifeq ($(BR2_PACKAGE_LIBSODIUM),y)
USBGUARD_CONF_OPTS += --with-crypto-library=sodium
USBGUARD_DEPENDENCIES += libsodium
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
USBGUARD_CONF_OPTS += --enable-systemd
USBGUARD_DEPENDENCIES += systemd
else
USBGUARD_CONF_OPTS += --disable-systemd
endif

ifeq ($(BR2_PACKAGE_LIBSECCOMP),y)
USBGUARD_CONF_OPTS += --enable-seccomp
USBGUARD_DEPENDENCIES += libseccomp
else
USBGUARD_CONF_OPTS += --disable-seccomp
endif

ifeq ($(BR2_PACKAGE_LIBCAP_NG),y)
USBGUARD_CONF_OPTS += --enable-libcapng
USBGUARD_DEPENDENCIES += libcap-ng
endif

define USBGUARD_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/usbguard/S20usbguard \
		$(TARGET_DIR)/etc/init.d/S20usbguard
endef

$(eval $(autotools-package))
