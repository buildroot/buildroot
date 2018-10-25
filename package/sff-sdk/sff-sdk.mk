################################################################################
#
# sff-sdk
#
################################################################################
SFF_SDK_VERSION = master
SFF_SDK_SITE = git@github.com:Metrological/SDK_SFF.git
SFF_SDK_SITE_METHOD = git
SFF_SDK_INSTALL_STAGING = YES
SFF_SDK_INSTALL_TARGET = YES

define SFF_SDK_INSTALL_STAGING_CMDS
	cp -Rpf $(@D)/usr/include/*.h $(STAGING_DIR)/usr/include/
	$(INSTALL) -m 0755 -D $(@D)/usr/lib/* $(STAGING_DIR)/usr/lib/
endef

define SFF_SDK_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(@D)/usr/lib/* $(STAGING_DIR)/usr/lib/
endef

$(eval $(generic-package))
