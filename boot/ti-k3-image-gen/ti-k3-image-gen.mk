################################################################################
#
# ti-k3-image-gen
#
################################################################################

TI_K3_IMAGE_GEN_VERSION = 08.06.00.007
TI_K3_IMAGE_GEN_SITE = https://git.ti.com/cgit/k3-image-gen/k3-image-gen/snapshot
TI_K3_IMAGE_GEN_SOURCE = k3-image-gen-$(TI_K3_IMAGE_GEN_VERSION).tar.gz
TI_K3_IMAGE_GEN_LICENSE = BSD-3-Clause
TI_K3_IMAGE_GEN_LICENSE_FILES = LICENSE
TI_K3_IMAGE_GEN_INSTALL_IMAGES = YES

# - ti-k3-image-gen is used to build tiboot3.bin, using the
#   r5-u-boot-spl.bin file from the ti-k3-r5-loader package. Hence the
#   dependency on ti-k3-r5-loader.
# - the ti-k3-image-gen makefiles seem to need some feature from Make
#   v4.0, similar to u-boot.
TI_K3_IMAGE_GEN_DEPENDENCIES = \
	host-arm-gnu-toolchain \
	host-python3 \
	host-openssl \
	host-uboot-tools \
	ti-k3-r5-loader \
	ti-k3-boot-firmware \
	$(BR2_MAKE_HOST_DEPENDENCY)

TI_K3_IMAGE_GEN_FW_TYPE = $(call qstrip,$(BR2_TARGET_TI_K3_IMAGE_GEN_FW_TYPE))
TI_K3_IMAGE_GEN_SOC = $(call qstrip,$(BR2_TARGET_TI_K3_IMAGE_GEN_SOC))
TI_K3_IMAGE_GEN_SECTYPE = $(call qstrip,$(BR2_TARGET_TI_K3_IMAGE_GEN_SECTYPE))

TI_K3_IMAGE_GEN_SYSFW = $(TI_K3_IMAGE_GEN_FW_TYPE)-firmware-$(TI_K3_IMAGE_GEN_SOC)-$(TI_K3_IMAGE_GEN_SECTYPE).bin

define TI_K3_IMAGE_GEN_CONFIGURE_CMDS
	cp $(BINARIES_DIR)/ti-sysfw/$(TI_K3_IMAGE_GEN_SYSFW) $(@D)
endef

define TI_K3_IMAGE_GEN_BUILD_CMDS
	$(TARGET_MAKE_ENV) \
	$(BR2_MAKE) -C $(@D) \
		SOC=$(TI_K3_IMAGE_GEN_SOC) \
		SOC_TYPE=$(TI_K3_IMAGE_GEN_SECTYPE) \
		CONFIG=evm \
		CROSS_COMPILE=$(HOST_DIR)/bin/arm-none-eabi- \
		SBL=$(BINARIES_DIR)/r5-u-boot-spl.bin \
		O=$(@D)/tmp \
		BIN_DIR=$(@D)
endef

define TI_K3_IMAGE_GEN_INSTALL_IMAGES_CMDS
	cp $(@D)/tiboot3.bin $(BINARIES_DIR)
endef

$(eval $(generic-package))
