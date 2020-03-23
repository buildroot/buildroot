################################################################################
#
# dns320l-daemon
#
################################################################################

DNS320L_DAEMON_VERSION = 1.0
DNS320L_DAEMON_SOURCE = tip.tar.bz2
DNS320L_DAEMON_SITE = https://www.aboehler.at/hg/dns320l-daemon/archive
DNS320L_DAEMON_INSTALL_STAGING = YES
DNS320L_DAEMON_LICENSE = GPL-3
DNS320L_DAEMON_DEPENDENCIES = iniparser

DNS320L_DAEMON_CONFIGURE_OPTS = $(TARGET_CONFIGURE_OPTS)

define DNS320L_DAEMON_BUILD_CMDS
	$(DNS320L_DAEMON_CONFIGURE_OPTS) $(TARGET_MAKE_ENV) $(MAKE) -C $(@D)
endef

define DNS320L_DAEMON_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/dns320l-daemon $(STAGING_DIR)/usr/bin/
	$(INSTALL) -D -m 0600 $(@D)/dns320l-daemon.ini $(STAGING_DIR)/etc/
	$(INSTALL) -D -m 0644 $(@D)/dns320l-daemon.service $(STAGING_DIR)/lib/systemd/system/
endef

define DNS320L_DAEMON_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/dns320l-daemon $(TARGET_DIR)/usr/bin/
	$(INSTALL) -D -m 0600 $(@D)/dns320l-daemon.ini $(TARGET_DIR)/etc/
	$(INSTALL) -D -m 0644 $(@D)/dns320l-daemon.service $(TARGET_DIR)/lib/systemd/system/
endef

define HOST_DNS320L_DAEMON_BUILD_CMDS
	$(HOST_CONFIGURE_OPTS) $(HOST_MAKE_ENV) $(MAKE) -C $(@D)
endef

define HOST_DNS320L_DAEMON_INSTALL_CMDS
	$(INSTALL) -D -m 0755 $(@D)/dns320l-daemon $(HOST_DIR)/usr/bin/
	$(INSTALL) -D -m 0600 $(@D)/dns320l-daemon.ini $(HOST_DIR)/etc/
endef

$(eval $(generic-package))
$(eval $(host-generic-package))
