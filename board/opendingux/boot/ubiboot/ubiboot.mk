################################################################################
#
# UbiBoot
#
################################################################################

UBIBOOT_VERSION = 121d5ae7af
UBIBOOT_SITE = $(call github,pcercuei,UBIBoot,$(UBIBOOT_VERSION))
UBIBOOT_BOARD_NAME = $(call qstrip,$(BR2_TARGET_UBIBOOT_BOARDNAME))

UBIBOOT_LICENSE = GPLv2+
UBIBOOT_LICENSE_FILES = README

UBIBOOT_INSTALL_IMAGES = YES

define UBIBOOT_BUILD_CMDS
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D) CONFIG=$(UBIBOOT_BOARD_NAME)
endef

define UBIBOOT_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)/ubiboot
	$(INSTALL) -D -m 0755 $(@D)/output/$(UBIBOOT_BOARD_NAME)/* $(BINARIES_DIR)/ubiboot
endef

$(eval $(generic-package))

ifeq ($(BR2_TARGET_UBIBOOT),y)
# we NEED a board name unless we're at make source
ifeq ($(filter source,$(MAKECMDGOALS)),)
ifeq ($(UBIBOOT_BOARD_NAME),)
$(error NO UBIBoot board name set. Check your BR2_BOOT_UBIBOOT_BOARDNAME setting)
endif
endif

endif
