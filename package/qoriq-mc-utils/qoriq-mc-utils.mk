################################################################################
#
# qoriq-mc-utils
#
################################################################################

QORIQ_MC_UTILS_VERSION = 10.39.0
QORIQ_MC_UTILS_SITE = $(call github,nxp-qoriq,mc-utils,mc_release_$(QORIQ_MC_UTILS_VERSION))
QORIQ_MC_UTILS_LICENSE = BSD-3-Clause
QORIQ_MC_UTILS_INSTALL_IMAGES = YES
QORIQ_MC_UTILS_DEPENDENCIES = host-dtc

QORIQ_MC_UTILS_DPC_FILES = $(call qstrip,$(BR2_PACKAGE_QORIQ_MC_UTILS_DPC_CUSTOM_PATH))
QORIQ_MC_UTILS_DPC_INTREE = $(call qstrip,$(BR2_PACKAGE_QORIQ_MC_UTILS_DPC_INTREE))
QORIQ_MC_UTILS_DPL_FILES = $(call qstrip,$(BR2_PACKAGE_QORIQ_MC_UTILS_DPL_CUSTOM_PATH))
QORIQ_MC_UTILS_DPL_INTREE = $(call qstrip,$(BR2_PACKAGE_QORIQ_MC_UTILS_DPL_INTREE))
QORIQ_MC_UTILS_INSTALL_PATH = $(call qstrip,$(BR2_PACKAGE_QORIQ_MC_UTILS_TARGET_INSTALL_PATH))

ifeq ($(QORIQ_MC_UTILS_INSTALL_PATH),)
QORIQ_MC_UTILS_INSTALL_TARGET = NO
endif

define QORIQ_MC_UTILS_INSTALL_FILES
	$(INSTALL) -d $(1)
	$(foreach file, $(QORIQ_MC_UTILS_DPC_FILES) $(QORIQ_MC_UTILS_DPL_FILES), \
		PATH=$(BR_PATH) dtc -I dts -O dtb $(file).dts -o $(1)/$(notdir $(file)).dtb
	)
	$(foreach file, $(QORIQ_MC_UTILS_DPC_INTREE) $(QORIQ_MC_UTILS_DPL_INTREE), \
		$(INSTALL) -D $(@D)/config/$(file).dtb $(1)/$(notdir $(file)).dtb
	)
endef

define QORIQ_MC_UTILS_BUILD_CMDS
	PATH=$(BR_PATH) $(MAKE) -C $(@D)/config/
endef

define QORIQ_MC_UTILS_INSTALL_IMAGES_CMDS
	$(call QORIQ_MC_UTILS_INSTALL_FILES,$(BINARIES_DIR))
endef

define QORIQ_MC_UTILS_INSTALL_TARGET_CMDS
	$(call QORIQ_MC_UTILS_INSTALL_FILES,$(TARGET_DIR)/$(QORIQ_MC_UTILS_INSTALL_PATH))
endef

$(eval $(generic-package))
