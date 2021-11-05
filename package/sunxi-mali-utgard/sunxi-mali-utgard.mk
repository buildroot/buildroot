################################################################################
#
# sunxi-mali-utgard
#
################################################################################

SUNXI_MALI_UTGARD_VERSION = 418f55585e76f375792dbebb3e97532f0c1c556d
SUNXI_MALI_UTGARD_SITE = $(call github,bootlin,mali-blobs,$(SUNXI_MALI_UTGARD_VERSION))
SUNXI_MALI_UTGARD_INSTALL_STAGING = YES
SUNXI_MALI_UTGARD_PROVIDES = libegl libgles
SUNXI_MALI_UTGARD_LICENSE = Allwinner End User Licence Agreement
SUNXI_MALI_UTGARD_EULA_ORIGINAL = EULA\ for\ Mali\ 400MP\ _AW.pdf
SUNXI_MALI_UTGARD_EULA_NO_SPACES = EULA_for_Mali_400MP_AW.pdf
SUNXI_MALI_UTGARD_LICENSE_FILES = $(SUNXI_MALI_UTGARD_EULA_NO_SPACES)

SUNXI_MALI_UTGARD_REV = $(call qstrip,$(BR2_PACKAGE_SUNXI_MALI_UTGARD_REVISION))

ifeq ($(BR2_arm),y)
SUNXI_MALI_UTGARD_ARCH=arm
else ifeq ($(BR2_aarch64),y)
SUNXI_MALI_UTGARD_ARCH=arm64
endif

define SUNXI_MALI_UTGARD_INSTALL_STAGING_CMDS
	mkdir -p $(STAGING_DIR)/usr/lib $(STAGING_DIR)/usr/include

	cp -rf $(@D)/$(SUNXI_MALI_UTGARD_REV)/$(SUNXI_MALI_UTGARD_ARCH)/fbdev/*.so* \
		$(STAGING_DIR)/usr/lib/
	cp -rf $(@D)/include/fbdev/* $(STAGING_DIR)/usr/include/

	$(INSTALL) -D -m 0644 package/sunxi-mali-utgard/egl.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/egl.pc
	$(INSTALL) -D -m 0644 package/sunxi-mali-utgard/glesv2.pc \
		$(STAGING_DIR)/usr/lib/pkgconfig/glesv2.pc
endef

define SUNXI_MALI_UTGARD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib
	cp -rf $(@D)/$(SUNXI_MALI_UTGARD_REV)/$(SUNXI_MALI_UTGARD_ARCH)/fbdev/*.so* \
		$(TARGET_DIR)/usr/lib/
endef

define SUNXI_MALI_UTGARD_FIXUP_LICENSE_FILE
	mv $(@D)/$(SUNXI_MALI_UTGARD_EULA_ORIGINAL) $(@D)/$(SUNXI_MALI_UTGARD_EULA_NO_SPACES)
endef

SUNXI_MALI_UTGARD_POST_PATCH_HOOKS += SUNXI_MALI_UTGARD_FIXUP_LICENSE_FILE

$(eval $(generic-package))
