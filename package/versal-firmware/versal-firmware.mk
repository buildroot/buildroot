################################################################################
#
# versal-firmware
#
################################################################################

VERSAL_FIRMWARE_VERSION = $(call qstrip,$(BR2_PACKAGE_VERSAL_FIRMWARE_VERSION))
VERSAL_FIRMWARE_SITE = $(call github,Xilinx,soc-prebuilt-firmware,$(VERSAL_FIRMWARE_VERSION))
VERSAL_FIRMWARE_LICENSE = MIT
VERSAL_FIRMWARE_LICENSE_FILES = LICENSE
VERSAL_FIRMWARE_INSTALL_TARGET = NO
VERSAL_FIRMWARE_INSTALL_IMAGES = YES

define VERSAL_FIRMWARE_INSTALL_IMAGES_CMDS
	$(foreach f,plm.elf psmfw.elf vpl_gen_fixed.pdi,\
		$(INSTALL) -D -m 0755 $(@D)/$(BR2_PACKAGE_VERSAL_FIRMWARE_BOARD)-versal/$(f) \
			$(BINARIES_DIR)/$(f)
	)
endef

$(eval $(generic-package))
