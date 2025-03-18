################################################################################
#
# cgroupfs-v2-mount
#
################################################################################

CGROUPFS_V2_MOUNT_VERSION =
CGROUPFS_V2_MOUNT_SITE =

define CGROUPFS_V2_MOUNT_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUPS)
endef

define CGROUPFS_V2_MOUNT_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D \
		$(CGROUPFS_V2_MOUNT_PKGDIR)/S30cgroupfs2 \
		$(TARGET_DIR)/etc/init.d/S30cgroupfs2
endef

$(eval $(generic-package))
