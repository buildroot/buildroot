################################################################################
#
# UbiBoot
#
################################################################################

UBIBOOT_VERSION = f5a317e
UBIBOOT_SITE = $(call github,pcercuei,UBIBoot,$(UBIBOOT_VERSION))
UBIBOOT_BOARD_NAME = $(call qstrip,$(BR2_PACKAGE_UBIBOOT_BOARDNAME))

UBIBOOT_LICENSE = GPLv2+
UBIBOOT_LICENSE_FILES = README

UBIBOOT_INSTALL_IMAGES = YES

define UBIBOOT_BUILD_CMDS
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D) CONFIG=$(UBIBOOT_BOARD_NAME)
endef

define UBIBOOT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/output/$(UBIBOOT_BOARD_NAME)/*.bin $(BINARIES_DIR)
endef

$(eval $(generic-package))
