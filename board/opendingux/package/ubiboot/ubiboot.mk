################################################################################
#
# UbiBoot
#
################################################################################

UBIBOOT_VERSION = 125aa60
UBIBOOT_SITE = $(call github,pcercuei,UBIBoot,$(UBIBOOT_VERSION))
UBIBOOT_BOARD_NAME = $(call qstrip,$(BR2_PACKAGE_UBIBOOT_BOARDNAME))

UBIBOOT_LICENSE = GPLv2+
UBIBOOT_LICENSE_FILES = README

UBIBOOT_INSTALL_IMAGES = YES

define UBIBOOT_BUILD_CMDS
	mkdir $(@D)/compiled

	# Compile regular build
	$(MAKE) CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D) CONFIG=$(UBIBOOT_BOARD_NAME)
	mv $(@D)/output/$(UBIBOOT_BOARD_NAME)/*.bin $(@D)/compiled

	# Compile STAGE1 build
	$(MAKE) STAGE1_ONLY=y CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D) CONFIG=$(UBIBOOT_BOARD_NAME) clean
	$(MAKE) STAGE1_ONLY=y CROSS_COMPILE="$(TARGET_CROSS)" -C $(@D) CONFIG=$(UBIBOOT_BOARD_NAME)
	mv $(@D)/output/$(UBIBOOT_BOARD_NAME)/*.bin $(@D)/compiled
endef

define UBIBOOT_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/compiled/*.bin $(BINARIES_DIR)
endef

$(eval $(generic-package))
