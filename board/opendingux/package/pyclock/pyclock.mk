#############################################################
#
# pyclock
#
#############################################################

PYCLOCK_VERSION = bd4a9d2
PYCLOCK_SITE = $(call github,OpenDingux,pyCLOCK,$(PYCLOCK_VERSION))

ifeq ($(BR2_PACKAGE_GMENU2X),y)
PYCLOCK_DEPENDENCIES += gmenu2x
define PYCLOCK_INSTALL_TARGET_GMENU2X
	$(INSTALL) -m 0644 -D $(TOPDIR)/board/opendingux/package/pyclock/20_pyclock \
		$(TARGET_DIR)/usr/share/gmenu2x/sections/settings/20_pyclock
endef
endif

define PYCLOCK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/pyclock3.dge $(TARGET_DIR)/usr/bin/pyclock
	$(INSTALL) -m 0755 -d $(TARGET_DIR)/usr/share/pyclock/
	$(INSTALL) -m 0644 -t $(TARGET_DIR)/usr/share/pyclock/ $(@D)/*.wav
	$(PYCLOCK_INSTALL_TARGET_GMENU2X)
endef

$(eval $(generic-package))
