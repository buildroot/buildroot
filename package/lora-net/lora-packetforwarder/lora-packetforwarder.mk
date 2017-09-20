################################################################################
#
# lora-packetforwarder
#
################################################################################
LORA_PACKETFORWARDER_VERSION = 13b2db5466e5aef7a513b856b740ed98af07f446
LORA_PACKETFORWARDER_SITE_METHOD = git
LORA_PACKETFORWARDER_SITE = https://github.com/kersing/packet_forwarder-OLD.git
LORA_PACKETFORWARDER_INSTALL_STAGING = YES
LORA_PACKETFORWARDER_DEPENDENCIES =  lora-gateway 

define LORA_PACKETFORWARDER_BUILD_CMDS
	$(TARGET_MAKE_ENV) CROSS_COMPILE=$(TARGET_CROSS) LGW_PATH=$(STAGING_DIR)/usr/include/libloragw $(MAKE) $(LORA_PACKETFORWARDER_EXTRA_MAKE_CFLAGS) -C $(@D)/poly_pkt_fwd 
endef

define LORA_PACKETFORWARDER_INSTALL_STAGING_CMDS
    $(INSTALL) -D -m 0755 $(@D)/poly_pkt_fwd/poly_pkt_fwd $(STAGING_DIR)/usr/bin/poly_pkt_fwd
endef

define LORA_PACKETFORWARDER_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/poly_pkt_fwd/poly_pkt_fwd $(TARGET_DIR)/usr/bin/poly_pkt_fwd
endef


$(eval $(generic-package))
