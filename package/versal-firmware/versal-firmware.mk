################################################################################
#
# versal-firmware
#
################################################################################

VERSAL_FIRMWARE_VERSION = $(call qstrip,$(BR2_PACKAGE_VERSAL_FIRMWARE_VERSION))
VERSAL_FIRMWARE_SITE = $(call github,nealfrager,buildroot-firmware,$(VERSAL_FIRMWARE_VERSION))
VERSAL_FIRMWARE_LICENSE = Xilinx-Binary-Only
VERSAL_FIRMWARE_LICENSE_FILES = LICENSE
VERSAL_FIRMWARE_INSTALL_TARGET = NO
VERSAL_FIRMWARE_INSTALL_IMAGES = YES

define VERSAL_FIRMWARE_INSTALL_IMAGES_CMDS
	$(foreach f,plm.elf psmfw.elf vpl_gen_fixed.pdi,\
		$(INSTALL) -D -m 0755 $(@D)/$(BR2_PACKAGE_VERSAL_FIRMWARE_BOARD)/$(BR2_PACKAGE_VERSAL_FIRMWARE_BOARD)_$(f) \
			$(BINARIES_DIR)/$(BR2_PACKAGE_VERSAL_FIRMWARE_BOARD)_$(f)
	)
endef

$(eval $(generic-package))
