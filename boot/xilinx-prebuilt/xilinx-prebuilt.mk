################################################################################
#
# xilinx-prebuilt
#
################################################################################

XILINX_PREBUILT_VERSION = $(call qstrip,$(BR2_TARGET_XILINX_PREBUILT_VERSION))
XILINX_PREBUILT_SITE = $(call github,Xilinx,soc-prebuilt-firmware,$(XILINX_PREBUILT_VERSION))
XILINX_PREBUILT_LICENSE = MIT
XILINX_PREBUILT_LICENSE_FILES = LICENSE
XILINX_PREBUILT_INSTALL_TARGET = NO
XILINX_PREBUILT_INSTALL_IMAGES = YES

XILINX_PREBUILT_FAMILY = $(call qstrip,$(BR2_TARGET_XILINX_PREBUILT_FAMILY))
XILINX_PREBUILT_BOARD = $(call qstrip,$(BR2_TARGET_XILINX_PREBUILT_BOARD))

XILINX_PREBUILT_BOARD_DIR = $(@D)/$(XILINX_PREBUILT_BOARD)-$(XILINX_PREBUILT_FAMILY)

ifeq ($(BR2_TARGET_XILINX_PREBUILT_VERSAL),y)
# We need the *.pdi glob, because the file has different names for the
# different boards, but there is only one, and it has to be named
# vpl_gen_fixed.pdi when installed.
define XILINX_PREBUILT_INSTALL
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_BOARD_DIR)/plm.elf \
		$(BINARIES_DIR)/plm.elf
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_BOARD_DIR)/psmfw.elf \
		$(BINARIES_DIR)/psmfw.elf
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_BOARD_DIR)/*.pdi \
		$(BINARIES_DIR)/vpl_gen_fixed.pdi
endef
else # BR2_TARGET_XILINX_PREBUILT_VERSAL
define XILINX_PREBUILT_INSTALL
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_BOARD_DIR)/pmufw.elf \
		$(BINARIES_DIR)/pmufw.elf
endef
endif # BR2_TARGET_XILINX_PREBUILT_VERSAL

define XILINX_PREBUILT_INSTALL_IMAGES_CMDS
	$(XILINX_PREBUILT_INSTALL)
endef

$(eval $(generic-package))
