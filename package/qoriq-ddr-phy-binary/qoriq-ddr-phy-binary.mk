################################################################################
#
# qoriq-ddr-phy-binary
#
################################################################################

QORIQ_DDR_PHY_BINARY_VERSION = lf-6.12.3-1.0.0
QORIQ_DDR_PHY_BINARY_SITE = $(call github,nxp-qoriq,ddr-phy-binary,$(QORIQ_DDR_PHY_BINARY_VERSION))
QORIQ_DDR_PHY_BINARY_LICENSE = NXP Binary EULA
QORIQ_DDR_PHY_BINARY_LICENSE_FILES = NXP-Binary-EULA.txt
QORIQ_DDR_PHY_BINARY_INSTALL_IMAGES = YES
QORIQ_DDR_PHY_BINARY_INSTALL_TARGET = NO

define QORIQ_DDR_PHY_BINARY_INSTALL_IMAGES_CMDS
	$(INSTALL) -D $(@D)/lx2160a/fip_ddr.bin $(BINARIES_DIR)/fip_ddr.bin
endef

$(eval $(generic-package))
