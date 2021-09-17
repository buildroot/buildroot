################################################################################
#
# detect-bad-arch
#
################################################################################

define DETECT_BAD_ARCH_BUILD_CMDS
	echo "int main(void) { return 0; }" | $(HOSTCC) -x c -o $(@D)/foo -
endef

define DETECT_BAD_ARCH_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/foo $(TARGET_DIR)/usr/bin/foo
endef

$(eval $(generic-package))
