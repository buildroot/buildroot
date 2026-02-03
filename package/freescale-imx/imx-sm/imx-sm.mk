################################################################################
#
# imx-sm
#
################################################################################

IMX_SM_VERSION = lf-6.18.37-2.1.0
IMX_SM_SITE = $(call github,nxp-imx,imx-sm,$(IMX_SM_VERSION))
IMX_SM_LICENSE = BSD-3-Clause
IMX_SM_LICENSE_FILES = LICENSE.txt SCR.txt

IMX_SM_INSTALL_IMAGES = YES
IMX_SM_INSTALL_TARGET = NO

IMX_SM_DEPENDENCIES = host-arm-gnu-toolchain

IMX_SM_OUTPUT_BIN = m33_image.bin

# note: we don't use the TOOLS variable here as recommended by the SM
# documentation because buildroot adds the "host-" prefix to the
# toolchain's directory name, which wouldn't work. Instead, we use
# SM_CROSS_COMPILE, which is normally based on TOOLS.
IMX_SM_MAKE_ENV = \
	$(TARGET_MAKE_ENV) \
	SM_CROSS_COMPILE=$(HOST_DIR)/bin/arm-none-eabi-

define IMX_SM_BUILD_CMDS
	$(IMX_SM_MAKE_ENV) $(MAKE) -C $(@D) config=$(BR2_PACKAGE_IMX_SM_CFG) cfg
	$(IMX_SM_MAKE_ENV) $(MAKE) -C $(@D) config=$(BR2_PACKAGE_IMX_SM_CFG) all
endef

# the output binary is used to build the boot container
define IMX_SM_INSTALL_IMAGES_CMDS
	cp $(@D)/build/$(BR2_PACKAGE_IMX_SM_CFG)/$(IMX_SM_OUTPUT_BIN) \
		$(BINARIES_DIR)/$(IMX_SM_OUTPUT_BIN)
endef

$(eval $(generic-package))
