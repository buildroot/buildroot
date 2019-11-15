################################################################################
#
# ucresolv
#
################################################################################

UCRESOLV_VERSION = b58d49e165208791f84b44e3c079b1b4ef6d5c9d
UCRESOLV_SITE_METHOD = git
UCRESOLV_SITE = git://github.com/Comcast/libucresolv.git
UCRESOLV_INSTALL_STAGING = YES

define UCRESOLV_INSTALL_TARGET_CMDS
    cp -a $(@D)/src/libucresolv.so* $(TARGET_DIR)/usr/lib
endef

define UCRESOLV_INSTALL_STAGING_CMDS
    cp -a $(@D)/src/libucresolv.so* $(STAGING_DIR)/usr/lib
endef
$(eval $(cmake-package))
