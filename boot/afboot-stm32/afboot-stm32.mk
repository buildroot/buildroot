################################################################################
#
# afboot-stm32
#
################################################################################

AFBOOT_STM32_VERSION = 3566acd582e5536fb60864281788a30f5527df2d
AFBOOT_STM32_SITE = $(call github,mcoquelin-stm32,afboot-stm32,$(AFBOOT_STM32_VERSION))
AFBOOT_STM32_INSTALL_IMAGES = YES
AFBOOT_STM32_INSTALL_TARGET = NO

define AFBOOT_STM32_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) -C $(@D) CROSS_COMPILE=$(TARGET_CROSS) all \
		KERNEL_ADDR=$(BR2_TARGET_AFBOOT_STM32_KERNEL_ADDR) \
		DTB_ADDR=$(BR2_TARGET_AFBOOT_STM32_DTB_ADDR)
endef

define AFBOOT_STM32_INSTALL_IMAGES_CMDS
	$(INSTALL) -m 0755 -t $(BINARIES_DIR) -D $(@D)/stm32*.bin
endef

$(eval $(generic-package))
