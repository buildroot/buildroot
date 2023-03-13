################################################################################
#
# hwclock-initscript
#
################################################################################

define HWCLOCK_INITSCRIPT_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(HWCLOCK_INITSCRIPT_PKGDIR)/S20hwclock \
		$(TARGET_DIR)/etc/init.d/S20hwclock
endef

$(eval $(generic-package))
