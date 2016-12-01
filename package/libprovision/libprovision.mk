################################################################################
#
# libprovision
#
################################################################################

LIBPROVISION_VERSION = 9ef7d7b5680b8270ecdab87b1e210bcede748e7a
LIBPROVISION_SITE_METHOD = git
LIBPROVISION_SITE = git@github.com:Metrological/libprovision.git
LIBPROVISION_LICENSE = PROPRIETARY
LIBPROVISION_REDISTRIBUTE = NO
LIBPROVISION_INSTALL_STAGING = YES

LIBPROVISION_DEPENDENCIES = openssl cppsdk

ifeq ($(BR2_PACKAGE_DXDRM),y)
define LIBPROVISIONPROXY_INSTALL_STAGING
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovisionproxy.so $(STAGING_DIR)/usr/lib/libprovisionproxy.so
endef
define LIBPROVISIONPROXY_INSTALL_TARGET
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovisionproxy.so $(TARGET_DIR)/usr/lib/libprovisionproxy.so
endef
else
define LIBPROVISIONPROXY_INSTALL_STAGING
	$(INSTALL) -m 644 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovisionproxy.a $(STAGING_DIR)/usr/lib/libprovisionproxy.a
endef
endif

define LIBPROVISION_INSTALL_STAGING_CMDS
	$(LIBPROVISIONPROXY_INSTALL_STAGING)
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovision.so $(STAGING_DIR)/usr/lib/libprovision.so
	$(INSTALL) -d -m 755 $(STAGING_DIR)/usr/include/provision
	$(INSTALL) -m 644 $(@D)/include/provision/*.h $(STAGING_DIR)/usr/include/provision
	$(INSTALL) -m 644 $(@D)/provision.pc $(STAGING_DIR)/usr/lib/pkgconfig
endef

define LIBPROVISION_INSTALL_TARGET_CMDS
	$(INSTALL) -m 755 $(@D)/$(call qstrip,$(BR2_ARCH))/libprovision.so $(TARGET_DIR)/usr/lib/libprovision.so
	$(LIBPROVISIONPROXY_INSTALL_TARGET)
endef

$(eval $(generic-package))
