################################################################################
#
# Build the xfs root filesystem image
#
################################################################################

ROOTFS_XFS_SIZE = $(call qstrip,$(BR2_TARGET_ROOTFS_XFS_SIZE))
ifeq ($(BR2_TARGET_ROOTFS_XFS)-$(ROOTFS_XFS_SIZE),y-)
$(error BR2_TARGET_ROOTFS_XFS_SIZE cannot be empty)
endif

ROOTFS_XFS_MKFS_OPTS = $(call qstrip,$(BR2_TARGET_ROOTFS_XFS_MKFS_OPTIONS))

# qstrip results in stripping consecutive spaces into a single one. So the
# variable is not qstrip-ed to preserve the integrity of the string value.
ROOTFS_XFS_LABEL = $(subst ",,$(BR2_TARGET_ROOTFS_XFS_LABEL))
#" comment to balance quotes/parenthesis for syntax highlighting)

ROOTFS_XFS_OPTS = \
	-f \
	-p '$(TARGET_DIR)' \
	-L '$(ROOTFS_XFS_LABEL)' \
	$(ROOTFS_XFS_MKFS_OPTS)

ROOTFS_XFS_DEPENDENCIES = host-xfsprogs

define ROOTFS_XFS_CMD
	$(RM) -f $@
	truncate -s $(ROOTFS_XFS_SIZE) $@
	$(HOST_DIR)/sbin/mkfs.xfs $(ROOTFS_XFS_OPTS) $@
endef

$(eval $(rootfs))
