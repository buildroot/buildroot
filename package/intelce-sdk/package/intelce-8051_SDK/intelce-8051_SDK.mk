################################################################################
#
# intelce-8051_SDK
#
################################################################################
INTELCE_8051_SDK_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_8051_SDK_SITE = ${INTELCE_SDK_DIR}/8051_SDK
INTELCE_8051_SDK_SITE_METHOD = local
INTELCE_8051_SDK_LICENSE = PROPRIETARY
INTELCE_8051_SDK_REDISTRIBUTE = NO
INTELCE_8051_SDK_DEPENDENCIES = intelce-sdk
INTELCE_8051_SDK_INSTALL_STAGING = YES

define INTELCE_8051_SDK_BUILD_CMDS
endef

define INTELCE_8051_SDK_INSTALL_STAGING_CMDS
endef

define INTELCE_8051_SDK_INSTALL_TARGET_CMDS
endef

$(eval $(generic-package))
