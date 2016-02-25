################################################################################
#
# intelce-edl
#
################################################################################
INTELCE_EDL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_EDL_SITE = ${INTELCE_SDK_DIR}/edl
INTELCE_EDL_SITE_METHOD = local
INTELCE_EDL_LICENSE = PROPRIETARY
INTELCE_EDL_REDISTRIBUTE = NO
INTELCE_EDL_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-idl intelce-audio intelce-SMD_Common intelce-smd_tools intelce-pal intelce-flash_appdata intelce-system_utils
INTELCE_EDL_INSTALL_STAGING = YES

define INTELCE_EDL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) bld
endef

define INTELCE_EDL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_EDL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
