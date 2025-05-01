################################################################################
#
# rockchip-rkbin
#
################################################################################

ROCKCHIP_RKBIN_VERSION = f43a462e7a1429a9d407ae52b4745033034a6cf9
ROCKCHIP_RKBIN_SITE = https://github.com/rockchip-linux/rkbin.git
ROCKCHIP_RKBIN_SITE_METHOD = git
ROCKCHIP_RKBIN_LICENSE = PROPRIETARY
ROCKCHIP_RKBIN_LICENSE_FILES = LICENSE

ROCKCHIP_RKBIN_INSTALL_IMAGES = YES
ROCKCHIP_RKBIN_INSTALL_TARGET = NO

ROCKCHIP_RKBIN_BL31_FILENAME = $(call qstrip,$(BR2_PACKAGE_ROCKCHIP_RKBIN_BL31_FILENAME))
ROCKCHIP_RKBIN_TPL_FILENAME = $(call qstrip,$(BR2_PACKAGE_ROCKCHIP_RKBIN_TPL_FILENAME))
ROCKCHIP_RKBIN_TEE_FILENAME = $(call qstrip,$(BR2_PACKAGE_ROCKCHIP_RKBIN_TEE_FILENAME))

define ROCKCHIP_RKBIN_INSTALL_IMAGES_CMDS
	$(foreach f, \
		$(ROCKCHIP_RKBIN_BL31_FILENAME) \
		$(ROCKCHIP_RKBIN_TPL_FILENAME) \
		$(ROCKCHIP_RKBIN_TEE_FILENAME) \
		, \
		$(INSTALL) -D -m 0644 -t $(BINARIES_DIR) $(@D)/$(f)
	)
endef

$(eval $(generic-package))
