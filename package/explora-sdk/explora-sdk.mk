################################################################################
#
# explora-sdk
#
################################################################################
EXPLORA_SDK_VERSION = 9714373f5fd1c1790d7848ef54a8c6d14776ad15
EXPLORA_SDK_SITE = git@github.com:Metrological/SDK_Explora.git
EXPLORA_SDK_SITE_METHOD = git
EXPLORA_SDK_INSTALL_STAGING = YES

define EXPLORA_SDK_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(STAGING_DIR)/usr/lib
	$(INSTALL) -D -m 0644 $(@D)/libs/* $(STAGING_DIR)/usr/lib/

	$(INSTALL) -d $(STAGING_DIR)/usr/libi/pkgconfig
	$(INSTALL) -D -m 0644 $(@D)/packages/* $(STAGING_DIR)/usr/lib/pkgconfig

	$(INSTALL) -d $(STAGING_DIR)/usr/include/refsw
	$(INSTALL) -d $(STAGING_DIR)/usr/include/widevine
	$(INSTALL) -d $(STAGING_DIR)/usr/include/EGL
	$(INSTALL) -d $(STAGING_DIR)/usr/include/KHR
	$(INSTALL) -d $(STAGING_DIR)/usr/include/GLES
	$(INSTALL) -d $(STAGING_DIR)/usr/include/GLES2
	cp -r $(@D)/includes/* $(STAGING_DIR)/usr/include
endef

define EXPLORA_SDK_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/usr/lib
	$(INSTALL) -D -m 0644 $(@D)/libs/* $(STAGING_DIR)/usr/lib/
	$(INSTALL) -d $(TARGET_DIR)/etc/init.d
	$(INSTALL) -D -m 0750 $(@D)/bin/S40boxinfo $(TARGET_DIR)/etc/init.d
	$(INSTALL) -d $(TARGET_DIR)/bin
	$(INSTALL) -D -m 0750 $(@D)/bin/get_tlv_data.bin $(TARGET_DIR)/bin
	$(INSTALL) -d $(TARGET_DIR)/lib/firmware
	$(INSTALL) -D -m 0640 $(@D)/firmware/sage/release/* $(TARGET_DIR)/lib/firmware
endef

$(eval $(generic-package))
