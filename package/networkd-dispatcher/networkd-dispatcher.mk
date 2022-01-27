################################################################################
#
# networkd-dispatcher
#
################################################################################

NETWORKD_DISPATCHER_VERSION = 2.1
NETWORKD_DISPATCHER_SOURCE = networkd-dispatcher-$(NETWORKD_DISPATCHER_VERSION).tar.bz2
NETWORKD_DISPATCHER_SITE = https://gitlab.com/craftyguy/networkd-dispatcher/-/archive/$(NETWORKD_DISPATCHER_VERSION)
NETWORKD_DISPATCHER_LICENSE = GPL-3.0
NETWORKD_DISPATCHER_LICENSE_FILES = LICENSE

define NETWORKD_DISPATCHER_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/networkd-dispatcher $(TARGET_DIR)/usr/bin/networkd-dispatcher
	mkdir -p $(TARGET_DIR)/etc/networkd-dispatcher/{routable,dormant,no-carrier,off,carrier,degraded,configuring,configured}.d
endef

define NETWORKD_DISPATCHER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 0644 $(@D)/networkd-dispatcher.service \
		$(TARGET_DIR)/usr/lib/systemd/system/networkd-dispatcher.service
	$(INSTALL) -D -m 0644 $(@D)/networkd-dispatcher.conf \
		$(TARGET_DIR)/etc/conf.d/networkd-dispatcher.conf
endef

$(eval $(generic-package))
