################################################################################
#
# intelce-video_ces
#
################################################################################
INTELCE_VIDEO_CES_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDEO_CES_SITE = ${INTELCE_SDK_DIR}/video_ces
INTELCE_VIDEO_CES_SITE_METHOD = local
INTELCE_VIDEO_CES_LICENSE = PROPRIETARY
INTELCE_VIDEO_CES_REDISTRIBUTE = NO
INTELCE_VIDEO_CES_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-platform_config intelce-intel_ce_pm intelce-sec
INTELCE_VIDEO_CES_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_DEPENDENCIES += intelce-fw_load 
endif

define INTELCE_VIDEO_CES_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_VIDEO_CES_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_VIDEO_CES_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
