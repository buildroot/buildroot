#############################################################
#
# gcwconnect
#
#############################################################

GCWCONNECT_VERSION = dfa3343
GCWCONNECT_SITE = $(call github,hanskokx,gcwconnect,$(GCWCONNECT_VERSION))
GCWCONNECT_DEPENDENCIES = host-dos2unix gmenu2x

ifeq ($(BR2_PACKAGE_GMENU2X),y)
GCWCONNECT_DEPENDENCIES += gmenu2x
define GCWCONNECT_INSTALL_TARGET_GMENU2X
	$(INSTALL) -m 0644 -D $(TOPDIR)/board/opendingux/package/gcwconnect/20_gcwconnect \
		$(TARGET_DIR)/usr/share/gmenu2x/sections/settings/20_gcwconnect
endef
endif

define GCWCONNECT_INSTALL_TARGET_CMDS
	$(HOST_DIR)/bin/dos2unix $(@D)/gcwconnect.py
	$(INSTALL) -m 0755 -D $(@D)/gcwconnect.py $(TARGET_DIR)/usr/bin/gcwconnect
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/gcwconnect/
	$(INSTALL) -m 0644 -t $(TARGET_DIR)/usr/share/gcwconnect/ $(@D)/data/*
	$(GCWCONNECT_INSTALL_TARGET_GMENU2X)
endef

$(eval $(generic-package))
