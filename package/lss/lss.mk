################################################################################
#
# lss
#
################################################################################
LSS_VERSION = a91633d172407f6c83dd69af11510b37afebb7f9
LSS_SITE_METHOD = git
LSS_SITE = https://chromium.googlesource.com/linux-syscall-support
LSS_INSTALL_STAGING = YES

define LSS_INSTALL_STAGING_CMDS
	if [ ! -d "${@D}/usr/include/third_party/lss" ] ; then \
		mkdir -p $(STAGING_DIR)/usr/include/third_party/lss; \
	fi; \
	$(INSTALL) -D $(@D)/linux_syscall_support.h $(STAGING_DIR)/usr/include/third_party/lss/;
endef

$(eval $(generic-package))
