################################################################################
#
# xboot
#
################################################################################

XBOOT_VERSION = aa7582bc447bcd319e5cfd84923d428a36278ef9
XBOOT_SITE = git://github.com/xboot/xboot.git
XBOOT_PLATFORM_NAME = $(call qstrip,$(BR2_TARGET_XBOOT_PLATFORM))

XBOOT_LICENSE = GPLv3
XBOOT_LICENSE_FILES = COPYING

XBOOT_INSTALL_IMAGES = YES

define XBOOT_BUILD_CMDS
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" PLATFORM=$(BR2_TARGET_XBOOT_PLATFORM) SDL_CONFIG=$(STAGING_DIR)/usr/bin/sdl2-config -C $(@D)
endef

ifeq ($(findstring sandbox, $(XBOOT_PLATFORM_NAME)), sandbox)
define XBOOT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0755 $(@D)/output/xboot $(TARGET_DIR)/usr/bin/
endef
else
define XBOOT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0755 $(@D)/output/xboot.bin $(BINARIES_DIR)/
endef
endif

$(eval $(generic-package))

ifeq ($(BR2_TARGET_XBOOT),y)
ifeq ($(filter source,$(MAKECMDGOALS)),)
ifeq ($(XBOOT_PLATFORM_NAME),)
$(error NO xboot platform name set. Check your BR2_TARGET_XBOOT_PLATFORM setting)
endif
endif

endif
