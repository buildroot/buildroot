################################################################################
#
# open-isns
#
################################################################################

OPEN_ISNS_VERSION = 0.102
OPEN_ISNS_SITE = $(call github,open-iscsi,open-isns,v$(OPEN_ISNS_VERSION))
OPEN_ISNS_LICENSE = LGPL-2.1+
OPEN_ISNS_LICENSE_FILES = COPYING
OPEN_ISNS_INSTALL_STAGING = YES

OPEN_ISNS_CONF_OPTS = -Dslp=disabled

ifeq ($(BR2_PACKAGE_OPENSSL),y)
OPEN_ISNS_DEPENDENCIES += openssl
OPEN_ISNS_CONF_OPTS += -Dsecurity=enabled
else
OPEN_ISNS_CONF_OPTS += -Dsecurity=disabled
endif

ifeq ($(BR2_INIT_SYSTEMD),)
define OPEN_ISNS_REMOVE_SYSTEMD_UNITS
	rm $(TARGET_DIR)/usr/lib/systemd/system/isnsd.service
	rm $(TARGET_DIR)/usr/lib/systemd/system/isnsd.socket
	rmdir --ignore-fail-on-non-empty $(TARGET_DIR)/usr/lib/systemd/system
	rmdir --ignore-fail-on-non-empty $(TARGET_DIR)/usr/lib/systemd
endef
OPEN_ISNS_POST_INSTALL_TARGET_HOOKS += OPEN_ISNS_REMOVE_SYSTEMD_UNITS
endif

$(eval $(meson-package))
