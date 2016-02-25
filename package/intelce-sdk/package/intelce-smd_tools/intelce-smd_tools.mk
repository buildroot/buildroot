################################################################################
#
# intelce-smd_tools
#
################################################################################
INTELCE_SMD_TOOLS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SMD_TOOLS_SITE = ${INTELCE_SDK_DIR}/smd_tools
INTELCE_SMD_TOOLS_SITE_METHOD = local
INTELCE_SMD_TOOLS_LICENSE = PROPRIETARY
INTELCE_SMD_TOOLS_REDISTRIBUTE = NO
INTELCE_SMD_TOOLS_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-sven linux intelce-SMD_Common
INTELCE_SMD_TOOLS_INSTALL_STAGING = YES

define INTELCE_SMD_TOOLS_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_SMD_TOOLS_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_SMD_TOOLS_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
