################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 3b68f177bf8ec51b3c36ba1e7e160a349ede328d
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl cppsdk

define LIBPROVISION_INSTALL_STAGING_CMDS
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovision.so $(STAGING_DIR)/usr/lib/libprovision.so
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovisionproxy.so $(STAGING_DIR)/usr/lib/libprovisionproxy.so
	$(INSTALL) -d -m 755 $(STAGING_DIR)/usr/include/rpc
	$(INSTALL) -m 644 $(@D)/include/rpc/*.h $(STAGING_DIR)/usr/include/rpc
	$(INSTALL) -d -m 755 $(STAGING_DIR)/usr/include/provision
	$(INSTALL) -m 644 $(@D)/include/provision/*.h $(STAGING_DIR)/usr/include/provision
	$(INSTALL) -m 644 $(@D)/provision.pc $(STAGING_DIR)/usr/lib/pkgconfig
endef

define LIBPROVISION_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovision.so $(TARGET_DIR)/usr/lib/libprovision.so
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovisionproxy.so $(TARGET_DIR)/usr/lib/libprovisionproxy.so
endef

$(eval $(generic-package))
