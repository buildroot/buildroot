################################################################################
#
# xilinx-prebuilt
#
################################################################################

XILINX_PREBUILT_VERSION = $(call qstrip,$(BR2_TARGET_XILINX_PREBUILT_VERSION))

ifeq ($(BR2_TARGET_XILINX_PREBUILT_VERSAL_XSA),y)
XILINX_PREBUILT_FILE = $(call qstrip,$(BR2_TARGET_XILINX_PREBUILT_VERSAL_XSA_LOCATION))
XILINX_PREBUILT_SITE = $(patsubst %/,%,$(dir $(XILINX_PREBUILT_FILE)))
XILINX_PREBUILT_SOURCE = $(notdir $(XILINX_PREBUILT_FILE))
define XILINX_PREBUILT_EXTRACT_CMDS
	$(UNZIP) $(XILINX_PREBUILT_DL_DIR)/$(XILINX_PREBUILT_SOURCE) -d $(@D)
endef
else # BR2_TARGET_XILINX_PREBUILT_VERSAL_XSA
XILINX_PREBUILT_SITE = $(call github,Xilinx,soc-prebuilt-firmware,$(XILINX_PREBUILT_VERSION))
XILINX_PREBUILT_LICENSE = MIT
XILINX_PREBUILT_LICENSE_FILES = LICENSE
endif # BR2_TARGET_XILINX_PREBUILT_VERSAL_XSA

XILINX_PREBUILT_INSTALL_TARGET = NO
XILINX_PREBUILT_INSTALL_IMAGES = YES

XILINX_PREBUILT_FAMILY = $(call qstrip,$(BR2_TARGET_XILINX_PREBUILT_FAMILY))
XILINX_PREBUILT_BOARD = $(call qstrip,$(BR2_TARGET_XILINX_PREBUILT_BOARD))

XILINX_PREBUILT_BOARD_DIR = $(@D)/$(XILINX_PREBUILT_BOARD)-$(XILINX_PREBUILT_FAMILY)

ifeq ($(BR2_TARGET_XILINX_PREBUILT_VERSAL),y)
# We need the *.pdi glob, because the file has different names for the
# different boards, but there is only one, and it has to be named
# vpl_gen_fixed.pdi when installed.
ifeq ($(BR2_TARGET_XILINX_PREBUILT_VERSAL_XSA),y)
# Supports either plm.elf or plmfw.elf filenames
XILINX_PREBUILT_PLM = $(@D)/pdi_files/gen_files/plm*.elf
# Unlike the psmfw.elf file for Xilinx development boards,
# AMD Vivado Design Suite currently generates a file named psm_fw.elf.
# Future versions of AMD Vivado will generate a file named psmfw.elf,
# so to support current and future AMD Vivado versions, the filename
# psm*fw.elf is used.
XILINX_PREBUILT_PSMFW = $(@D)/pdi_files/static_files/psm*fw.elf
XILINX_PREBUILT_PDI = $(@D)/*.pdi
else # BR2_TARGET_XILINX_PREBUILT_VERSAL_XSA
# Supports either plm.elf or plmfw.elf filenames
XILINX_PREBUILT_PLM = $(XILINX_PREBUILT_BOARD_DIR)/plm*.elf
XILINX_PREBUILT_PSMFW = $(XILINX_PREBUILT_BOARD_DIR)/psmfw.elf
XILINX_PREBUILT_PDI = $(XILINX_PREBUILT_BOARD_DIR)/*.pdi
endif # BR2_TARGET_XILINX_PREBUILT_VERSAL_XSA

ifneq ($(BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PLM),y)
define XILINX_PREBUILT_INSTALL_VERSAL_PLM
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_PLM) \
		$(BINARIES_DIR)/plm.elf
endef
endif # !BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PLM

ifneq ($(BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PSMFW),y)
define XILINX_PREBUILT_INSTALL_VERSAL_PSMFW
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_PSMFW) \
		$(BINARIES_DIR)/psmfw.elf
endef
endif # !BR2_TARGET_XILINX_EMBEDDEDSW_VERSAL_PSMFW

define XILINX_PREBUILT_INSTALL_VERSAL_PDI
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_PDI) \
		$(BINARIES_DIR)/vpl_gen_fixed.pdi
endef
else # BR2_TARGET_XILINX_PREBUILT_VERSAL
ifneq ($(BR2_TARGET_XILINX_EMBEDDEDSW_ZYNQMP_PMUFW),y)
define XILINX_PREBUILT_INSTALL_ZYNQMP_PMUFW
	$(INSTALL) -D -m 0755 $(XILINX_PREBUILT_BOARD_DIR)/pmufw.elf \
		$(BINARIES_DIR)/pmufw.elf
endef
endif # !BR2_TARGET_XILINX_EMBEDDEDSW_ZYNQMP_PMUFW
endif # BR2_TARGET_XILINX_PREBUILT_VERSAL

define XILINX_PREBUILT_INSTALL_IMAGES_CMDS
	$(XILINX_PREBUILT_INSTALL_VERSAL_PLM)
	$(XILINX_PREBUILT_INSTALL_VERSAL_PSMFW)
	$(XILINX_PREBUILT_INSTALL_VERSAL_PDI)
	$(XILINX_PREBUILT_INSTALL_ZYNQMP_PMUFW)
endef

$(eval $(generic-package))
