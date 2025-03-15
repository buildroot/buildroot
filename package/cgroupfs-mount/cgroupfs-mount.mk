################################################################################
#
# cgroupfs-mount
#
################################################################################

CGROUPFS_MOUNT_VERSION = 1.4
CGROUPFS_MOUNT_SITE = $(call github,tianon,cgroupfs-mount,$(CGROUPFS_MOUNT_VERSION))
CGROUPFS_MOUNT_LICENSE = GPL-3.0+
CGROUPFS_MOUNT_LICENSE_FILES = debian/copyright
CGROUPFS_MOUNT_CPE_ID_VALID = YES

define CGROUPFS_MOUNT_LINUX_CONFIG_FIXUPS
	$(call KCONFIG_ENABLE_OPT,CONFIG_BLK_CGROUP)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUPS)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_CPUACCT)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_DEVICE)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_FREEZER)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_WRITEBACK)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_SCHED)
	$(call KCONFIG_ENABLE_OPT,CONFIG_CGROUP_PIDS)
endef

define CGROUPFS_MOUNT_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/cgroupfs-mount $(TARGET_DIR)/usr/bin/cgroupfs-mount
	$(INSTALL) -D -m 0755 $(@D)/cgroupfs-umount $(TARGET_DIR)/usr/bin/cgroupfs-umount
endef

define CGROUPFS_MOUNT_INSTALL_INIT_SYSV
	$(INSTALL) -m 0755 -D $(CGROUPFS_MOUNT_PKGDIR)/S30cgroupfs \
		$(TARGET_DIR)/etc/init.d/S30cgroupfs
endef

$(eval $(generic-package))
