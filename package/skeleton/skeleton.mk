################################################################################
#
# skeleton
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_ADD_SKELETON_DEPENDENCY = NO

# The package is a dependency to ccache so ccache cannot be a dependency
HOST_SKELETON_ADD_CCACHE_DEPENDENCY = NO

# Although the $(HOST_DIR)/usr symlink is mostly for backward compatibility,
# there are weird packages that still require it (see host-systemd, and
# commit 35c11a027c88).
define HOST_SKELETON_INSTALL_CMDS
# check-package DoNotInstallToHostdirUsr
	$(Q)ln -snf . $(HOST_DIR)/usr
	$(Q)mkdir -p $(HOST_DIR)/lib
	$(Q)mkdir -p $(HOST_DIR)/include
	$(Q)case $(HOSTARCH) in \
		(*64|s390x) ln -snf lib $(HOST_DIR)/lib64;; \
		(*)   ln -snf lib $(HOST_DIR)/lib32;; \
	esac
endef

$(eval $(virtual-package))
$(eval $(host-generic-package))
