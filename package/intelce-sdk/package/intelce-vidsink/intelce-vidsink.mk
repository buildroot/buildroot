################################################################################
#
# intelce-vidsink
#
################################################################################
INTELCE_VIDSINK_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDSINK_SITE = ${INTELCE_SDK_DIR}/vidsink
INTELCE_VIDSINK_SITE_METHOD = local
INTELCE_VIDSINK_LICENSE = PROPRIETARY
INTELCE_VIDSINK_REDISTRIBUTE = NO
INTELCE_VIDSINK_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-api intelce-core intelce-osal intelce-auto_eas intelce-sven intelce-smd_tools intelce-common linux intelce-SMD_Common intelce-vidrend intelce-vidpproc
INTELCE_VIDSINK_INSTALL_STAGING = YES

define INTELCE_VIDSINK_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_VIDSINK_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_VIDSINK_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
