################################################################################
#
# sunxi-mali-utgard-driver
#
################################################################################

SUNXI_MALI_UTGARD_DRIVER_VERSION = 73a80d550f2f181b5fc7fc2d859e15d077d845e4
SUNXI_MALI_UTGARD_DRIVER_SITE = $(call github,giuliobenetti,sunxi-mali,$(SUNXI_MALI_UTGARD_DRIVER_VERSION))
SUNXI_MALI_UTGARD_DRIVER_DEPENDENCIES = linux
SUNXI_MALI_UTGARD_DRIVER_LICENSE = GPL-2.0
SUNXI_MALI_UTGARD_DRIVER_LICENSE_FILES = LICENSE

SUNXI_MALI_UTGARD_DRIVER_MAKE_OPTS = \
	$(LINUX_MAKE_FLAGS) \
	KDIR=$(LINUX_DIR)

define SUNXI_MALI_UTGARD_DRIVER_USE_APPLY_PATCHES
	ln -sf $(SUNXI_MALI_UTGARD_REV)/series $(@D)/patches
	$(SED) 's|quilt push -a|$(TOPDIR)/support/scripts/apply-patches.sh . ../patches|' \
		$(@D)/build.sh
endef

SUNXI_MALI_UTGARD_DRIVER_POST_PATCH_HOOKS += SUNXI_MALI_UTGARD_DRIVER_USE_APPLY_PATCHES

define SUNXI_MALI_UTGARD_DRIVER_BUILD_CMDS
	cd $(@D) && $(SUNXI_MALI_UTGARD_DRIVER_MAKE_OPTS) \
		$(SHELL) ./build.sh -r $(SUNXI_MALI_UTGARD_REV) -j $(PARALLEL_JOBS) -b
endef

define SUNXI_MALI_UTGARD_DRIVER_INSTALL_TARGET_CMDS
	cd $(@D) && $(SUNXI_MALI_UTGARD_DRIVER_MAKE_OPTS) \
		$(SHELL) ./build.sh -r $(SUNXI_MALI_UTGARD_REV) -j $(PARALLEL_JOBS) -i
endef

define SUNXI_MALI_UTGARD_DRIVER_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_CMA)
	$(call KCONFIG_ENABLE_OPT,CONFIG_DMA_CMA)
	$(call KCONFIG_ENABLE_OPT,CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM)
endef

$(eval $(generic-package))
