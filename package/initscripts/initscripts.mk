################################################################################
#
# initscripts
#
################################################################################

ifeq ($(BR2_TARGET_GENERIC_NETWORK),y)
define INITSCRIPTS_INSTALL_TARGET_CMDS
	mkdir -p  $(TARGET_DIR)/etc/init.d
	$(INSTALL) -D -m 0755 package/initscripts/init.d/* $(TARGET_DIR)/etc/init.d/
endef
else
define INITSCRIPTS_INSTALL_TARGET_CMDS
	mkdir -p  $(TARGET_DIR)/etc/init.d
	$(INSTALL) -D -m 0755 package/initscripts/init.d/{rc?,S20urandom} $(TARGET_DIR)/etc/init.d/
endef
endif

$(eval $(generic-package))
