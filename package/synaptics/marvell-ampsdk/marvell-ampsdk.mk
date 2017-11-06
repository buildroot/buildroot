################################################################################
#
# marvell-firmware
#
################################################################################

MARVELL_AMPSDK_VERSION = 84488f16c331d395b7156fdb3fda607687b9f078
MARVELL_AMPSDK_SITE_METHOD = git
MARVELL_AMPSDK_SITE = git@github.com:Metrological/marvell-ampsdk.git

MARVELL_AMPSDK_INSTALL_STAGING = YES
MARVELL_AMPSDK_DEPENDENCIES = 
MARVELL_AMPSDK_LICENSE = CLOSED

define MARVELL_AMPSDK_BUILD_CMDS
# no buildable targets yet.
endef

define MARVELL_AMPSDK_INSTALL_LIBS
   $(INSTALL) -D -m 644 $(@D)/build/configs/$(1)/prebuilt/linux_bg4cdp_a0_rdk/lib/* $(2)/usr/lib
endef


define MARVELL_AMPSDK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 -d $(TARGET_DIR)/usr/lib

	$(call MARVELL_AMPSDK_INSTALL_LIBS,libampclient,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libOSAL,$(TARGET_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libgraphics,$(TARGET_DIR))
endef

define MARVELL_AMPSDK_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/lib/pkgconfig
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include

	$(call MARVELL_AMPSDK_INSTALL_LIBS,libampclient,$(STAGING_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libOSAL,$(STAGING_DIR))
	$(call MARVELL_AMPSDK_INSTALL_LIBS,libgraphics,$(STAGING_DIR))

endef

$(eval $(generic-package))
