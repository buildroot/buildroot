################################################################################
#
# pocketpy
#
################################################################################

POCKETPY_VERSION = 2.0.8
POCKETPY_SITE = $(call github,pocketpy,pocketpy,v$(POCKETPY_VERSION))
POCKETPY_LICENSE = MIT
POCKETPY_LICENSE_FILES = LICENSE
POCKETPY_INSTALL_STAGING = YES

POCKETPY_CONF_OPTS = -DPK_BUILD_SHARED_LIB=ON

define POCKETPY_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libpocketpy.so* $(TARGET_DIR)/usr/lib
endef

define POCKETPY_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0755 $(@D)/libpocketpy.so* $(STAGING_DIR)/usr/lib
	$(INSTALL) -m 755 -d $(STAGING_DIR)/usr/include/pocketpy
	cp -r $(@D)/include/* $(STAGING_DIR)/usr/include/pocketpy
endef

$(eval $(cmake-package))
