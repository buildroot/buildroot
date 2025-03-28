################################################################################
#
# qoriq-firmware-inphi
#
################################################################################

# Unlikely to ever be updated, keep a fixed version instead of following BSP tags
QORIQ_FIRMWARE_INPHI_VERSION = f22e9ff3bfed8342da6efb699e473b11fbad5695
QORIQ_FIRMWARE_INPHI_SITE = $(call github,nxp,qoriq-firmware-inphi,$(QORIQ_FIRMWARE_INPHI_VERSION))
QORIQ_FIRMWARE_INPHI_LICENSE = NXP Binary EULA
QORIQ_FIRMWARE_INPHI_LICENSE_FILES = EULA.txt
QORIQ_FIRMWARE_INPHI_INSTALL_IMAGES = YES

define QORIQ_FIRMWARE_INPHI_INSTALL_IMAGES_CMDS
	$(INSTALL) -D $(@D)/in112525-phy-ucode.txt $(BINARIES_DIR)/in112525-phy-ucode.txt
endef

$(eval $(generic-package))
