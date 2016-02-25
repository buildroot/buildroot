################################################################################
#
# intelce-smd_avcap_shim
#
################################################################################
INTELCE_SMD_AVCAP_SHIM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SMD_AVCAP_SHIM_SITE = ${INTELCE_SDK_DIR}/smd_avcap_shim
INTELCE_SMD_AVCAP_SHIM_SITE_METHOD = local
INTELCE_SMD_AVCAP_SHIM_LICENSE = PROPRIETARY
INTELCE_SMD_AVCAP_SHIM_REDISTRIBUTE = NO
INTELCE_SMD_AVCAP_SHIM_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-api intelce-auto_eas intelce-osal intelce-common intelce-sven linux intelce-core intelce-avcap intelce-SMD_Common intelce-clock_recovery intelce-clock
INTELCE_SMD_AVCAP_SHIM_INSTALL_STAGING = YES

define INTELCE_SMD_AVCAP_SHIM_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_SMD_AVCAP_SHIM_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_SMD_AVCAP_SHIM_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
