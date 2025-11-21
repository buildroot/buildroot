################################################################################
#
# skeleton-custom
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_CUSTOM_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_CUSTOM_ADD_SKELETON_DEPENDENCY = NO

SKELETON_CUSTOM_PROVIDES = skeleton

SKELETON_CUSTOM_INSTALL_STAGING = YES

SKELETON_CUSTOM_PATH = $(call qstrip,$(BR2_ROOTFS_SKELETON_CUSTOM_PATH))

ifeq ($(BR2_PACKAGE_SKELETON_CUSTOM)$(BR_BUILDING),yy)
ifeq ($(SKELETON_CUSTOM_PATH),)
$(error No path specified for the custom skeleton)
endif
endif

define SKELETON_CUSTOM_CONFIGURE_CMDS
	support/scripts/check-merged \
		-t skeleton \
		$(if $(BR2_ROOTFS_MERGED_USR),-u) \
		$(if $(BR2_ROOTFS_MERGED_BIN),-b) \
		$(SKELETON_CUSTOM_PATH)
endef

# The target-dir-warning file and the lib{32,64} symlinks are the only
# things we customise in the custom skeleton.
define SKELETON_CUSTOM_INSTALL_TARGET_CMDS
	$(call SYSTEM_RSYNC,$(SKELETON_CUSTOM_PATH),$(TARGET_DIR))
	$(call SYSTEM_USR_SYMLINKS_OR_DIRS,$(TARGET_DIR))
	$(call SYSTEM_LIB_SYMLINK,$(TARGET_DIR))
	$(INSTALL) -m 0644 support/misc/target-dir-warning.txt \
		$(TARGET_DIR_WARNING_FILE)
endef

# For the staging dir, we don't really care what we install, but we
# need the /lib and /usr/lib appropriately setup.
define SKELETON_CUSTOM_INSTALL_STAGING_CMDS
	$(call SYSTEM_RSYNC,$(SKELETON_CUSTOM_PATH),$(STAGING_DIR))
	$(call SYSTEM_USR_SYMLINKS_OR_DIRS,$(STAGING_DIR))
	$(call SYSTEM_LIB_SYMLINK,$(STAGING_DIR))
endef

$(eval $(generic-package))
