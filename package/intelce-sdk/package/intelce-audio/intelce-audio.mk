################################################################################
#
# intelce-audio
#
################################################################################
INTELCE_AUDIO_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AUDIO_SITE = ${INTELCE_SDK_DIR}/audio
INTELCE_AUDIO_SITE_METHOD = local
INTELCE_AUDIO_LICENSE = PROPRIETARY
INTELCE_AUDIO_REDISTRIBUTE = NO
INTELCE_AUDIO_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-htuple intelce-clock intelce-clock_recovery intelce-clock_control intelce-display intelce-avcap intelce-intel_ce_pm
INTELCE_AUDIO_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_AUDIO_DEPENDENCIES +=  intelce-iosf intelce-fw_load intelce-audio_fw_bin
endif

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V21),y)
    INTELCE_AUDIO_DEPENDENCIES += intelce-audio_fw
endif

define INTELCE_AUDIO_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_AUDIO_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_AUDIO_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
