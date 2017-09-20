################################################################################
#
# lora-gateway
#
################################################################################
LORA_GATEWAY_VERSION = 4f77b387f9893cb49749cf4d61ac4f9221829fc9
LORA_GATEWAY_SITE_METHOD = git
LORA_GATEWAY_SITE = https://github.com/kersing/lora_gateway-OLD.git
LORA_GATEWAY_INSTALL_STAGING = YES
LORA_GATEWAY_DEPENDENCIES = libusb libmpsse 

define LORA_GATEWAY_BUILD_CMDS
	$(TARGET_MAKE_ENV) CROSS_COMPILE=$(TARGET_CROSS) $(MAKE) -C $(@D)/libloragw libloragw.a 
endef

define LORA_GATEWAY_INSTALL_STAGING_CMDS
    $(INSTALL) -d -m 0755 $(STAGING_DIR)/usr/include/libloragw/inc
    $(INSTALL) -D -m 0644 $(@D)/libloragw/libloragw.a $(STAGING_DIR)/usr/lib
    $(INSTALL) -D -m 0644 $(@D)/libloragw/inc/* $(STAGING_DIR)/usr/include/libloragw/inc
    $(INSTALL) -D -m 0644 $(@D)/libloragw/library.cfg $(STAGING_DIR)/usr/include/libloragw
    $(INSTALL) -D -m 0644 $(@D)/libloragw/libloragw.a $(STAGING_DIR)/usr/include/libloragw  
endef

define LORA_GATEWAY_INSTALL_TARGET_CMDS
endef


$(eval $(generic-package))
