################################################################################
#
# firmware-imx
#
################################################################################

FIRMWARE_IMX_VERSION = 8.6
FIRMWARE_IMX_SITE = $(FREESCALE_IMX_SITE)
FIRMWARE_IMX_SOURCE = firmware-imx-$(FIRMWARE_IMX_VERSION).bin

FIRMWARE_IMX_LICENSE = NXP Semiconductor Software License Agreement
FIRMWARE_IMX_LICENSE_FILES = EULA COPYING
FIRMWARE_IMX_REDISTRIBUTE = NO

FIRMWARE_IMX_INSTALL_IMAGES = YES

FIRMWARE_IMX_PLATFORM_LOWER = $(shell echo $(BR2_PACKAGE_FREESCALE_IMX_PLATFORM) | tr A-Z a-z | head -c 5)

define FIRMWARE_IMX_EXTRACT_CMDS
	$(call FREESCALE_IMX_EXTRACT_HELPER,$(FIRMWARE_IMX_DL_DIR)/$(FIRMWARE_IMX_SOURCE))
endef

#
# DDR firmware
#

ifeq ($(BR2_PACKAGE_FIRMWARE_IMX_LPDDR4),y)
FIRMWARE_IMX_DDRFW_DIR = $(@D)/firmware/ddr/synopsys
define FIRMWARE_IMX_PREPARE_LPDDR4_FW
	$(TARGET_OBJCOPY) -I binary -O binary --pad-to 0x8000 --gap-fill=0x0 \
		$(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_$(1)_imem.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_$(1)_imem_pad.bin
	$(TARGET_OBJCOPY) -I binary -O binary --pad-to 0x4000 --gap-fill=0x0 \
		$(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_$(1)_dmem.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_$(1)_dmem_pad.bin
	cat $(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_$(1)_imem_pad.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_$(1)_dmem_pad.bin > \
		$(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_$(1)_fw.bin
endef

define FIRMWARE_IMX_INSTALL_IMAGE_DDR_FW
	# Create padded versions of lpddr4_pmu_* and generate lpddr4_pmu_train_fw.bin.
	# lpddr4_pmu_train_fw.bin is needed when generating imx8-boot-sd.bin
	# which is done in post-image script.
	$(call FIRMWARE_IMX_PREPARE_LPDDR4_FW,1d)
	$(call FIRMWARE_IMX_PREPARE_LPDDR4_FW,2d)
	cat $(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_1d_fw.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/lpddr4_pmu_train_2d_fw.bin > \
		$(BINARIES_DIR)/lpddr4_pmu_train_fw.bin
	ln -sf $(BINARIES_DIR)/lpddr4_pmu_train_fw.bin $(BINARIES_DIR)/ddr_fw.bin
endef
endif

ifeq ($(BR2_PACKAGE_FIRMWARE_IMX_DDR4),y)
FIRMWARE_IMX_DDRFW_DIR = $(@D)/firmware/ddr/synopsys
define FIRMWARE_IMX_PREPARE_DDR4_FW
	$(TARGET_OBJCOPY) -I binary -O binary --pad-to 0x8000 --gap-fill=0x0 \
		$(FIRMWARE_IMX_DDRFW_DIR)/ddr4_imem_$(1)_201810.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/ddr4_imem_$(1)_201810_pad.bin
	$(TARGET_OBJCOPY) -I binary -O binary --pad-to 0x4000 --gap-fill=0x0 \
		$(FIRMWARE_IMX_DDRFW_DIR)/ddr4_dmem_$(1)_201810.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/ddr4_dmem_$(1)_201810_pad.bin
	cat $(FIRMWARE_IMX_DDRFW_DIR)/ddr4_imem_$(1)_201810_pad.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/ddr4_dmem_$(1)_201810_pad.bin > \
		$(FIRMWARE_IMX_DDRFW_DIR)/ddr4_$(1)_201810_fw.bin
endef

define FIRMWARE_IMX_INSTALL_IMAGE_DDR_FW
	# Create padded versions of ddr4_* and generate ddr4_fw.bin.
	# ddr4_fw.bin is needed when generating imx8-boot-sd.bin
	# which is done in post-image script.
	$(call FIRMWARE_IMX_PREPARE_DDR4_FW,1d)
	$(call FIRMWARE_IMX_PREPARE_DDR4_FW,2d)
	cat $(FIRMWARE_IMX_DDRFW_DIR)/ddr4_1d_201810_fw.bin \
		$(FIRMWARE_IMX_DDRFW_DIR)/ddr4_2d_201810_fw.bin > \
		$(BINARIES_DIR)/ddr4_201810_fw.bin
	ln -sf $(BINARIES_DIR)/ddr4_201810_fw.bin $(BINARIES_DIR)/ddr_fw.bin
endef
endif

#
# HDMI firmware
#

ifeq ($(BR2_PACKAGE_FIRMWARE_IMX_NEEDS_HDMI_FW),y)
define FIRMWARE_IMX_INSTALL_IMAGE_HDMI_FW
	cp $(@D)/firmware/hdmi/cadence/signed_hdmi_imx8m.bin \
		$(BINARIES_DIR)/signed_hdmi_imx8m.bin
endef
endif

#
# EPDC firmware
#

ifeq ($(BR2_PACKAGE_FIRMWARE_IMX_NEEDS_EPDC_FW),y)
define FIRMWARE_IMX_INSTALL_TARGET_EPDC_FW
	mkdir -p $(TARGET_DIR)/lib/firmware/imx
	cp -r $(@D)/firmware/epdc $(TARGET_DIR)/lib/firmware/imx
	mv $(TARGET_DIR)/lib/firmware/imx/epdc/epdc_ED060XH2C1.fw.nonrestricted \
		$(TARGET_DIR)/lib/firmware/imx/epdc/epdc_ED060XH2C1.fw
endef
endif

#
# SDMA firmware
#

ifeq ($(BR2_PACKAGE_FIRMWARE_IMX_NEEDS_SDMA_FW),y)
define FIRMWARE_IMX_INSTALL_TARGET_SDMA_FW
	mkdir -p $(TARGET_DIR)/lib/firmware/imx/sdma
	cp -r $(@D)/firmware/sdma/sdma-$(FIRMWARE_IMX_PLATFORM_LOWER)*.bin \
	       $(TARGET_DIR)/lib/firmware/imx/sdma/
endef
endif

#
# VPU firmware
#

ifeq ($(BR2_PACKAGE_FIRMWARE_IMX_NEEDS_VPU_FW),y)
# special case for i.MX8X, which uses the same firmware as i.MX8
ifeq ($(BR2_PACKAGE_FREESCALE_IMX_PLATFORM_IMX8X),y)
FIRMWARE_IMX_VPU_PLATFORM = imx8
else
FIRMWARE_IMX_VPU_PLATFORM = $(FIRMWARE_IMX_PLATFORM_LOWER)
endif

define FIRMWARE_IMX_INSTALL_TARGET_VPU_FW
	mkdir -p $(TARGET_DIR)/lib/firmware/imx/vpu
	cp $(@D)/firmware/vpu/vpu_fw_$(FIRMWARE_IMX_VPU_PLATFORM)*.bin \
		$(TARGET_DIR)/lib/firmware/imx/vpu/
endef
endif

define FIRMWARE_IMX_INSTALL_IMAGES_CMDS
	$(FIRMWARE_IMX_INSTALL_IMAGE_DDR_FW)
	$(FIRMWARE_IMX_INSTALL_IMAGE_HDMI_FW)
endef

define FIRMWARE_IMX_INSTALL_TARGET_CMDS
	$(FIRMWARE_IMX_INSTALL_TARGET_EPDC_FW)
	$(FIRMWARE_IMX_INSTALL_TARGET_SDMA_FW)
	$(FIRMWARE_IMX_INSTALL_TARGET_VPU_FW)
endef

$(eval $(generic-package))
