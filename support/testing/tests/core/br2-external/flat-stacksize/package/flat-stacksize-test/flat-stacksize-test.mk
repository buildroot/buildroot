################################################################################
#
# flat-stacksize-test
#
################################################################################

# Define a stack size that is different from the default FLAT
# stack size (4096 bytes).
FLAT_STACKSIZE_TEST_FLAT_STACKSIZE = 8192

define FLAT_STACKSIZE_TEST_BUILD_CMDS
	$(TARGET_MAKE_ENV) $(MAKE) \
		-C $(FLAT_STACKSIZE_TEST_PKGDIR) O=$(@D) \
		$(TARGET_CONFIGURE_OPTS)
endef

define FLAT_STACKSIZE_TEST_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/flat_stacksize_test \
		$(TARGET_DIR)/usr/bin/flat_stacksize_test
endef

$(eval $(generic-package))
