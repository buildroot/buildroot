################################################################################
#
# mini-snmpd
#
################################################################################

MINI_SNMPD_VERSION = 2.0
MINI_SNMPD_SITE = https://github.com/troglobit/mini-snmpd/releases/download/v$(MINI_SNMPD_VERSION)
MINI_SNMPD_LICENSE = GPL-2.0
MINI_SNMPD_LICENSE_FILES = COPYING
MINI_SNMPD_CPE_ID_VENDOR = minisnmpd_project
MINI_SNMPD_CPE_ID_PRODUCT = minisnmpd
MINI_SNMPD_DEPENDENCIES = host-pkgconf
MINI_SNMPD_CONF_OPTS = --with-interfaces=$(BR2_PACKAGE_MINI_SNMPD_INTERFACES)

ifeq ($(BR2_PACKAGE_LIBCONFUSE),y)
MINI_SNMPD_DEPENDENCIES += libconfuse
MINI_SNMPD_CONF_OPTS += --with-config
# ethtool interface stats live in linux_ethtool.c, only built with libConfuse
ifeq ($(BR2_PACKAGE_ETHTOOL),y)
MINI_SNMPD_CONF_OPTS += --enable-ethtool
else
MINI_SNMPD_CONF_OPTS += --disable-ethtool
endif
define MINI_SNMPD_INSTALL_CONFIG
	$(INSTALL) -D -m 644 package/mini-snmpd/mini-snmpd.conf \
		$(TARGET_DIR)/etc/mini-snmpd.conf
endef
MINI_SNMPD_POST_INSTALL_TARGET_HOOKS += MINI_SNMPD_INSTALL_CONFIG
else
MINI_SNMPD_CONF_OPTS += --without-config
endif

define MINI_SNMPD_INSTALL_ETC_DEFAULT
	$(INSTALL) -D -m 644 package/mini-snmpd/mini-snmpd \
		$(TARGET_DIR)/etc/default/mini-snmpd
endef

MINI_SNMPD_POST_INSTALL_TARGET_HOOKS += MINI_SNMPD_INSTALL_ETC_DEFAULT

define MINI_SNMPD_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 package/mini-snmpd/S60mini-snmpd \
		$(TARGET_DIR)/etc/init.d/S60mini-snmpd
endef

$(eval $(autotools-package))
