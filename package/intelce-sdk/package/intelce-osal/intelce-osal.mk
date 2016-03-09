################################################################################
#
# intelce-osal
#
################################################################################
INTELCE_OSAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_OSAL_SITE = ${INTELCE_SDK_DIR}/osal
INTELCE_OSAL_SITE_METHOD = local
INTELCE_OSAL_LICENSE = PROPRIETARY
INTELCE_OSAL_REDISTRIBUTE = NO
INTELCE_OSAL_DEPENDENCIES = intelce-sdk linux intelce-SMD_Common 
INTELCE_OSAL_INSTALL_STAGING = YES

define INTELCE_OSAL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_OSAL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_OSAL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target    
endef

$(eval $(generic-package))
