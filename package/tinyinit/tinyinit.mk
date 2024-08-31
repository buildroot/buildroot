################################################################################
#
# tinyinit
#
################################################################################

define TINYINIT_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 -D $(TINYINIT_PKGDIR)/init $(TARGET_DIR)/sbin/init
	# Downside: In non-initramfs systems the symlink isn't used/needed
	(cd $(TARGET_DIR); ln -sf /sbin/init init)
endef

$(eval $(generic-package))
