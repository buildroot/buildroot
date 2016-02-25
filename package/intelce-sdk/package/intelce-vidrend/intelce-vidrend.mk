################################################################################
#
# intelce-vidrend
#
################################################################################
INTELCE_VIDREND_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDREND_SITE = ${INTELCE_SDK_DIR}/vidrend
INTELCE_VIDREND_SITE_METHOD = local
INTELCE_VIDREND_LICENSE = PROPRIETARY
INTELCE_VIDREND_REDISTRIBUTE = NO
INTELCE_VIDREND_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-api intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-platform_config intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-clock intelce-display intelce-SMD_Common intelce-vidpproc
INTELCE_VIDREND_INSTALL_STAGING = YES

define INTELCE_VIDREND_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_VIDREND_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev  
endef

define INTELCE_VIDREND_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
