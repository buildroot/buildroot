################################################################################
#
# imx-oei
#
################################################################################

IMX_OEI_VERSION = lf-6.18.37-2.1.0
IMX_OEI_SITE = $(call github,nxp-imx,imx-oei,$(IMX_OEI_VERSION))
IMX_OEI_LICENSE = BSD-3-Clause
IMX_OEI_LICENSE_FILES = LICENSE.txt SCR.txt

IMX_OEI_INSTALL_IMAGES = YES
IMX_OEI_INSTALL_TARGET = NO

IMX_OEI_DEPENDENCIES = host-arm-gnu-toolchain

# For now we only support OEI for DDR intialization
IMX_OEI_OUTPUT_BIN = oei-m33-ddr.bin

# no TOOLS variable - see rationale from imx-sm package
IMX_OEI_MAKE_ENV = \
	$(TARGET_MAKE_ENV) \
	OEI_CROSS_COMPILE=$(HOST_DIR)/bin/arm-none-eabi-

define IMX_OEI_BUILD_CMDS
	$(IMX_OEI_MAKE_ENV) $(MAKE) -C $(@D) \
		oei=ddr \
		board=$(BR2_PACKAGE_IMX_OEI_TARGET_BOARD) \
		r=$(BR2_PACKAGE_IMX_OEI_TARGET_REV)
endef

define IMX_OEI_INSTALL_IMAGES_CMDS
	cp $(@D)/build/$(BR2_PACKAGE_IMX_OEI_TARGET_BOARD)/ddr/$(IMX_OEI_OUTPUT_BIN) \
		$(BINARIES_DIR)/$(IMX_OEI_OUTPUT_BIN)
endef

$(eval $(generic-package))
