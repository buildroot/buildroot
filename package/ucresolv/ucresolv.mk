################################################################################
#
# ucresolv
#
################################################################################

UCRESOLV_VERSION = 996c3778b14936c26b49e30f8dbb4933cb2df49a
UCRESOLV_SITE_METHOD = git
UCRESOLV_SITE = https://github.com/Comcast/libucresolv.git
UCRESOLV_INSTALL_STAGING = YES

UCRESOLV_CONF_OPTS = -DBUILD_TESTING=OFF

define UCRESOLV_INSTALL_TARGET_CMDS
    cp -a $(@D)/src/libucresolv.so* $(TARGET_DIR)/usr/lib
endef

define UCRESOLV_INSTALL_STAGING_CMDS
    cp -a $(@D)/src/libucresolv.so* $(STAGING_DIR)/usr/lib
endef
$(eval $(cmake-package))
