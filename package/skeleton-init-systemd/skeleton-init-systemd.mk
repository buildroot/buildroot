################################################################################
#
# skeleton-init-systemd
#
################################################################################

# The skeleton can't depend on the toolchain, since all packages depends on the
# skeleton and the toolchain is a target package, as is skeleton.
# Hence, skeleton would depends on the toolchain and the toolchain would depend
# on skeleton.
SKELETON_INIT_SYSTEMD_ADD_TOOLCHAIN_DEPENDENCY = NO
SKELETON_INIT_SYSTEMD_ADD_SKELETON_DEPENDENCY = NO

SKELETON_INIT_SYSTEMD_DEPENDENCIES = skeleton-init-common

SKELETON_INIT_SYSTEMD_PROVIDES = skeleton

ifeq ($(BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW),y)

define SKELETON_INIT_SYSTEMD_ROOT_RO_OR_RW
	echo "/dev/root / auto rw 0 1" >$(TARGET_DIR)/etc/fstab
endef

else

define SKELETON_INIT_SYSTEMD_ROOT_RO_OR_RW
	echo "/dev/root / auto ro 0 1" >$(TARGET_DIR)/etc/fstab
endef

# On a R/O rootfs, /var is a tmpfs filesystem. So, at build time, we
# redirect /var to the "factory settings" location. Just before the
# filesystem gets created, the /var symlink will be replaced with
# a real (but empty) directory, and the "factory files" will be copied
# back there by the tmpfiles.d mechanism.
ifeq ($(BR2_INIT_SYSTEMD_VAR_FACTORY),y)
define SKELETON_INIT_SYSTEMD_PRE_ROOTFS_VAR
	rm -rf $(TARGET_DIR)/usr/share/factory/var
	mv $(TARGET_DIR)/var $(TARGET_DIR)/usr/share/factory/var
	mkdir -p $(TARGET_DIR)/var
	mkdir -p $(TARGET_DIR)/usr/lib/tmpfiles.d
	for i in $(TARGET_DIR)/usr/share/factory/var/* \
		 $(TARGET_DIR)/usr/share/factory/var/lib/* \
		 $(TARGET_DIR)/usr/share/factory/var/lib/systemd/*; do \
		[ -e "$${i}" ] || continue; \
		j="$${i#$(TARGET_DIR)/usr/share/factory}"; \
		if [ -L "$${i}" ]; then \
			printf "L+! %s - - - - %s\n" \
				"$${j}" "../usr/share/factory/$${j}" \
			|| exit 1; \
		else \
			printf "C! %s - - - -\n" "$${j}" \
			|| exit 1; \
		fi; \
	done >$(TARGET_DIR)/usr/lib/tmpfiles.d/00-buildroot-var.conf
	$(INSTALL) -D -m 0644 $(SKELETON_INIT_SYSTEMD_PKGDIR)/var.mount \
		$(TARGET_DIR)/usr/lib/systemd/system/var.mount
endef
SKELETON_INIT_SYSTEMD_ROOTFS_PRE_CMD_HOOKS += SKELETON_INIT_SYSTEMD_PRE_ROOTFS_VAR
endif  # BR2_INIT_SYSTEMD_VAR_FACTORY
endif  # BR2_TARGET_GENERIC_REMOUNT_ROOTFS_RW

ifeq ($(BR2_INIT_SYSTEMD_POPULATE_TMPFILES),y)
define SKELETON_INIT_SYSTEMD_CREATE_TMPFILES_HOOK
	HOST_SYSTEMD_TMPFILES=$(HOST_DIR)/bin/systemd-tmpfiles \
		$(SKELETON_INIT_SYSTEMD_PKGDIR)/fakeroot_tmpfiles.sh $(TARGET_DIR)
endef
SKELETON_INIT_SYSTEMD_ROOTFS_PRE_CMD_HOOKS += SKELETON_INIT_SYSTEMD_CREATE_TMPFILES_HOOK
endif  # BR2_INIT_SYSTEMD_POPULATE_TMPFILES

define SKELETON_INIT_SYSTEMD_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/home
	mkdir -p $(TARGET_DIR)/srv
	mkdir -p $(TARGET_DIR)/var
	ln -s ../run $(TARGET_DIR)/var/run
	# prevent install scripts to create var/lock as directory
	ln -s ../run/lock $(TARGET_DIR)/var/lock
	install -D -m644 $(SKELETON_INIT_SYSTEMD_PKGDIR)/legacy.conf $(TARGET_DIR)/usr/lib/tmpfiles.d/legacy.conf
	$(SKELETON_INIT_SYSTEMD_ROOT_RO_OR_RW)
endef

$(eval $(generic-package))
