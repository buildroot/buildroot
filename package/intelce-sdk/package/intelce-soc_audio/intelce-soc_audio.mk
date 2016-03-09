################################################################################
#
# intelce-soc_audio
#
################################################################################
INTELCE_SOC_AUDIO_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SOC_AUDIO_SITE = ${INTELCE_SDK_DIR}/soc_audio
INTELCE_SOC_AUDIO_SITE_METHOD = local
INTELCE_SOC_AUDIO_LICENSE = PROPRIETARY
INTELCE_SOC_AUDIO_REDISTRIBUTE = NO
INTELCE_SOC_AUDIO_DEPENDENCIES = intelce-sdk intelce-osal intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-cosai intelce-SMD_Common intelce-api
INTELCE_SOC_AUDIO_INSTALL_STAGING = YES

define INTELCE_SOC_AUDIO_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_SOC_AUDIO_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_SOC_AUDIO_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef
$(eval $(generic-package))
