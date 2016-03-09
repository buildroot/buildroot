################################################################################
#
# intelce-fw_load
#
################################################################################
INTELCE_FW_LOAD_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_FW_LOAD_SITE = ${INTELCE_SDK_DIR}/fw_load
INTELCE_FW_LOAD_SITE_METHOD = local
INTELCE_FW_LOAD_LICENSE = PROPRIETARY
INTELCE_FW_LOAD_REDISTRIBUTE = NO
INTELCE_FW_LOAD_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-api intelce-sec
INTELCE_FW_LOAD_INSTALL_STAGING = YES

define INTELCE_FW_LOAD_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_FW_LOAD_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_FW_LOAD_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
