################################################################################
#
# murata-cyw-fw
#
################################################################################

MURATA_CYW_FW_VERSION = 35459425949f0fa7de0b5c9f0c8bc0560087e1de
MURATA_CYW_FW_VERSION_NVRAM = fd6587f8183b612ea52404c7a73aeb2698099587
MURATA_CYW_FW_VERSION_BT_PATCH = 83f8e16423c47e195f52a06fd68ac92a20a80a9f
MURATA_CYW_FW_SITE = $(call github,murata-wireless,cyw-fmac-fw,$(MURATA_CYW_FW_VERSION))
MURATA_CYW_FW_EXTRA_DOWNLOADS = \
	$(call github,murata-wireless,cyw-fmac-nvram,$(MURATA_CYW_FW_VERSION_NVRAM))/cyw-fmac-nvram-$(MURATA_CYW_FW_VERSION_NVRAM).tar.gz \
	$(call github,murata-wireless,cyw-bt-patch,$(MURATA_CYW_FW_VERSION_BT_PATCH))/cyw-bt-patch-$(MURATA_CYW_FW_VERSION_BT_PATCH).tar.gz
MURATA_CYW_FW_LICENSE = PROPRIETARY
MURATA_CYW_FW_LICENSE_FILES = LICENCE.cypress
MURATA_CYW_FW_REDISTRIBUTE = NO

define MURATA_CYW_FW_EXTRACT_NVRAM_PATCH
	$(foreach tar,$(notdir $(MURATA_CYW_FW_EXTRA_DOWNLOADS)), \
		$(call suitable-extractor,$(tar)) $(MURATA_CYW_FW_DL_DIR)/$(tar) | \
		$(TAR) --strip-components=1 -C $(@D) $(TAR_OPTIONS) -
	)
endef
MURATA_CYW_FW_POST_EXTRACT_HOOKS += MURATA_CYW_FW_EXTRACT_NVRAM_PATCH

MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43012) += \
	cyfmac43012-sdio.bin \
	cyfmac43012-sdio.1LV.clm_blob \
	cyfmac43012-sdio.1LV.txt \
	BCM43012C0_003.001.015.0303.0267.1LV.sAnt.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43340) += \
	cyfmac43340-sdio.bin \
	cyfmac43340-sdio.1BW.txt \
	CYW43341B0.1BW.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43362) += \
	cyfmac43362-sdio.bin
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW4339) += \
	cyfmac4339-sdio.bin \
	CYW4335C0.ZP.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43430) += \
	cyfmac43430-sdio.bin
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43430_1DX) += \
	cyfmac43430-sdio.1DX.clm_blob \
	cyfmac43430-sdio.1DX.txt \
	BCM43430A1_001.002.009.0159.0528.1DX.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43430_1FX) += \
	cyfmac43430-sdio.1FX.clm_blob \
	cyfmac43430-sdio.1FX.txt
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43430_1LN) += \
	cyfmac43430-sdio.1LN.clm_blob
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43439) += \
	cyfmac43439-sdio.bin \
	cyfmac43439-sdio.1YN.clm_blob \
	cyfmac43439-sdio.1YN.txt \
	CYW4343A2_001.003.016.0031.0000.1YN.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43455) += \
	cyfmac43455-sdio.bin
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43455_1HK) += \
	cyfmac43455-sdio.1HK.clm_blob
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43455_1LC) += \
	cyfmac43455-sdio.1LC.clm_blob \
	cyfmac43455-sdio.1LC.txt
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW43455_1MW) += \
	cyfmac43455-sdio.1MW.clm_blob \
	cyfmac43455-sdio.1MW.txt \
	BCM4345C0_003.001.025.0187.0366.1MW.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW4354) += \
	cyfmac4354-sdio.bin \
	cyfmac4354-sdio.1BB.clm_blob \
	CYW4350C0.1BB.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW4356) += \
	cyfmac4356-pcie.bin \
	cyfmac4356-pcie.1CX.clm_blob \
	BCM4356A2_001.003.015.0112.0410.1CX.hcd
MURATA_CYW_FW_FILES_$(BR2_PACKAGE_MURATA_CYW_FW_CYW4359) += \
	cyfmac4359-pcie.bin \
	cyfmac4359-sdio.bin

# Helper that assumes filename with model has two dots (CHIP.MODEL.EXT),
# or a underscore with several dots (CHIP_MODEL.MODEL.MODEL.EXT), but
# filename without model has only single dot (CHIP.EXT).
murata-cyw-fw-strip-model = $(shell echo -n $(1) | sed -e 's/\..*\./\./' -e 's/_.*\./\./')

# Helper that strips model name and renames Bluetooth patch files to the ones
# expected by Linux kernel.
murata-cyw-fw-file-rename = $(call murata-cyw-fw-strip-model,$(patsubst CYW%,BCM%,$(patsubst cy%,brcm%,$(f))))

define MURATA_CYW_FW_INSTALL_TARGET_CMDS
	$(foreach f,$(MURATA_CYW_FW_FILES_y), \
		$(INSTALL) -m 0644 -D $(@D)/$(f) \
			$(TARGET_DIR)/lib/firmware/brcm/$(call murata-cyw-fw-file-rename,$(f))
	)
endef

$(eval $(generic-package))
