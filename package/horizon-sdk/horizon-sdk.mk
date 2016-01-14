################################################################################
#
# horizon-sdk
#
################################################################################

HORIZON_SDK_VERSION = 1
HORIZON_SDK_SITE = ../dawn
HORIZON_SDK_SITE_METHOD = local
HORIZON_SDK_INSTALL_STAGING = YES
HORIZON_SDK_LICENSE = PROPRIETARY

define HORIZON_SDK_INSTALL_STAGING_CMDS
	cp -Rf $(@D)/sdk/include/* $(STAGING_DIR)/usr/include/
	cp -Rf $(@D)/sdk/lib/* $(STAGING_DIR)/usr/lib/
	mkdir -p $(STAGING_DIR)/usr/lib/pkgconfig
	cp -Rf $(@D)/sdk/pkgconfig/* $(STAGING_DIR)/usr/lib/pkgconfig/
endef

define HORIZON_SDK_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib
	cp -Rf $(@D)/sdk/lib/* $(TARGET_DIR)/usr/lib/
	mkdir -p $(TARGET_DIR)/lib/modules/
	cp -Rf $(@D)/modules/nexus.ko $(TARGET_DIR)/lib/modules/
	grep -q 'eth0' $(TARGET_DIR)/etc/network/interfaces || \
		echo -e '\nauto eth0\niface eth0 inet dhcp\n' >> $(TARGET_DIR)/etc/network/interfaces
	grep -q 'eth2' $(TARGET_DIR)/etc/network/interfaces || \
		echo -e '\nauto eth2\niface eth2 inet dhcp\n' >> $(TARGET_DIR)/etc/network/interfaces
	$(INSTALL) -D -m 755 package/dawn-sdk/S11nexus $(TARGET_DIR)/etc/init.d/
	$(INSTALL) -D -m 755 package/dawn-sdk/S70refsw $(TARGET_DIR)/etc/init.d/
	cp -Rf $(@D)/bin/* $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))
