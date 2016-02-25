################################################################################
#
# intelce-SMD_Common
#
################################################################################
INTELCE_SMD_COMMON_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SMD_COMMON_SITE = ${INTELCE_SDK_DIR}/SMD_Common
INTELCE_SMD_COMMON_SITE_METHOD = local
INTELCE_SMD_COMMON_LICENSE = PROPRIETARY
INTELCE_SMD_COMMON_REDISTRIBUTE = NO
INTELCE_SMD_COMMON_DEPENDENCIES = intelce-sdk
INTELCE_SMD_COMMON_INSTALL_STAGING = YES
    
define INTELCE_SMD_COMMON_CONFIGURE_CMDS
   
endef

define INTELCE_SMD_COMMON_BUILD_CMDS    
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_SMD_COMMON_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_SMD_COMMON_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
