################################################################################
#
# intelce-audio_fw
#
################################################################################
INTELCE_AUDIO_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AUDIO_FW_SITE = ${INTELCE_SDK_DIR}/audio_fw
INTELCE_AUDIO_FW_SITE_METHOD = local
INTELCE_AUDIO_FW_LICENSE = PROPRIETARY
INTELCE_AUDIO_FW_REDISTRIBUTE = NO
INTELCE_AUDIO_FW_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-clock_control
INTELCE_AUDIO_FW_INSTALL_STAGING = YES

define INTELCE_AUDIO_FW_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_AUDIO_FW_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_AUDIO_FW_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
