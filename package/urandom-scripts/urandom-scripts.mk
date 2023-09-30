################################################################################
#
# urandom-scripts
#
################################################################################

define URANDOM_SCRIPTS_INSTALL_INIT_SYSV
	$(INSTALL) -D -m 0755 $(URANDOM_SCRIPTS_PKGDIR)/S01seedrng \
		$(TARGET_DIR)/etc/init.d/S01seedrng
endef

$(eval $(generic-package))
