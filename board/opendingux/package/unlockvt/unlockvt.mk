#############################################################
#
# unlockvt
#
#############################################################

UNLOCKVT_DIR=$(BUILD_DIR)/unlockvt

define UNLOCKVT_BUILD_CMDS
	mkdir -p $(UNLOCKVT_DIR)
	$(TARGET_CC) $(TARGET_CFLAGS) -s board/opendingux/package/unlockvt/unlockvt.c -o $(UNLOCKVT_DIR)/unlockvt
endef

define UNLOCKVT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(UNLOCKVT_DIR)/unlockvt $(TARGET_DIR)/usr/sbin/unlockvt
endef

$(eval $(generic-package))
