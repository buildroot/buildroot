################################################################################
#
# uma-sdk
#
################################################################################
UMA_SDK_VERSION = master
UMA_SDK_SITE = git@github.com:Metrological/OperatorDeliveries.git
UMA_SDK_SITE_METHOD = git
UMA_SDK_INSTALL_STAGING = YES
UMA_SDK_INSTALL_TARGET = YES

define UMA_SDK_INSTALL_STAGING_CMDS
        cp -Rf $(@D)/nos/player/* $(STAGING_DIR)/
endef

define UMA_SDK_INSTALL_TARGET_CMDS
        cp -Rf $(@D)/nos/player/* $(TARGET_DIR)/
endef


$(eval $(virtual-package))
