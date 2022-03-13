################################################################################
#
# iwd
#
################################################################################

IWD_VERSION = 1.24
IWD_SOURCE = iwd-$(IWD_VERSION).tar.xz
IWD_SITE = $(BR2_KERNEL_MIRROR)/linux/network/wireless
IWD_LICENSE = LGPL-2.1+
IWD_LICENSE_FILES = COPYING
IWD_CPE_ID_VENDOR = intel
IWD_CPE_ID_PRODUCT = inet_wireless_daemon
IWD_SELINUX_MODULES = networkmanager
# We're patching configure.ac
IWD_AUTORECONF = YES

IWD_CONF_OPTS = \
	--disable-manual-pages \
	--enable-external-ell
IWD_DEPENDENCIES = ell

ifeq ($(BR2_PACKAGE_DBUS),y)
IWD_CONF_OPTS += --enable-dbus-policy --with-dbus-datadir=/usr/share
IWD_DEPENDENCIES += dbus
else
IWD_CONF_OPTS += --disable-dbus-policy
endif

ifeq ($(BR2_PACKAGE_READLINE),y)
# iwd client depends on readline (GPL-3.0+)
IWD_LICENSE += , GPL-3.0+ (client)
IWD_CONF_OPTS += --enable-client
IWD_DEPENDENCIES += readline
else
IWD_CONF_OPTS += --disable-client
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
IWD_CONF_OPTS += --enable-systemd-service
IWD_DEPENDENCIES += systemd
else
IWD_CONF_OPTS += --disable-systemd-service
endif

ifeq ($(BR2_PACKAGE_SYSTEMD_RESOLVED),y)
IWD_RESOLV_SERVICE = systemd
else
IWD_RESOLV_SERVICE = resolvconf
endif

define IWD_INSTALL_CONFIG_FILE
	$(INSTALL) -D -m 644 package/iwd/main.conf $(TARGET_DIR)/etc/iwd/main.conf
	$(SED) 's,__RESOLV_SERVICE__,$(IWD_RESOLV_SERVICE),' $(TARGET_DIR)/etc/iwd/main.conf
endef

IWD_POST_INSTALL_TARGET_HOOKS += IWD_INSTALL_CONFIG_FILE

define IWD_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D package/iwd/S40iwd \
		$(TARGET_DIR)/etc/init.d/S40iwd
	mkdir -p $(TARGET_DIR)/var/lib/iwd
	ln -sf /tmp/iwd/hotspot $(TARGET_DIR)/var/lib/iwd/hotspot
endef

define IWD_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_ASYMMETRIC_KEY_TYPE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_AES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_CBC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_CMAC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_DES)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_ECB)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_HMAC)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_MD4)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_MD5)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_SHA1)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_SHA256)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_SHA512)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_USER_API_HASH)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CRYPTO_USER_API_SKCIPHER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_KEYS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_KEY_DH_OPERATIONS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_PKCS7_MESSAGE_PARSER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_PKCS8_PRIVATE_KEY_PARSER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_X509_CERTIFICATE_PARSER)
endef

$(eval $(autotools-package))
