################################################################################
#
# intelce-smd_sample_apps
#
################################################################################
INTELCE_SMD_SAMPLE_APPS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SMD_SAMPLE_APPS_SITE = ${INTELCE_SDK_DIR}/smd_sample_apps
INTELCE_SMD_SAMPLE_APPS_SITE_METHOD = local
INTELCE_SMD_SAMPLE_APPS_LICENSE = PROPRIETARY
INTELCE_SMD_SAMPLE_APPS_REDISTRIBUTE = NO
INTELCE_SMD_SAMPLE_APPS_DEPENDENCIES = intelce-sdk intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-smd_tools intelce-sven linux intelce-SMD_Common intelce-platform_config intelce-api intelce-core intelce-audio intelce-audio_fw intelce-clock intelce-clock_recovery intelce-demux intelce-viddec intelce-vidpproc intelce-display intelce-vidrend intelce-bufmon gstreamer1 intelce-edl intelce-system_utils intelce-tsout intelce-idl intelce-avcap intelce-smd_avcap_shim intelce-remux intelce-vidsink intelce-videnc intelce-mux intelce-sec
INTELCE_SMD_SAMPLE_APPS_INSTALL_STAGING = YES

define INTELCE_SMD_SAMPLE_APPS_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_SMD_SAMPLE_APPS_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_SMD_SAMPLE_APPS_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
