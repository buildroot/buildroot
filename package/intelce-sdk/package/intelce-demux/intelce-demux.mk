################################################################################
#
# intelce-demux
#
################################################################################
INTELCE_DEMUX_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DEMUX_SITE = ${INTELCE_SDK_DIR}/demux
INTELCE_DEMUX_SITE_METHOD = local
INTELCE_DEMUX_LICENSE = PROPRIETARY
INTELCE_DEMUX_REDISTRIBUTE = NO
INTELCE_DEMUX_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-clock_recovery intelce-pal intelce-auto_eas intelce-osal intelce-clock_control intelce-htuple intelce-smd_tools intelce-sven linux intelce-core intelce-api intelce-platform_config intelce-SMD_Common intelce-intel_ce_pm intelce-sec
INTELCE_DEMUX_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_DEPENDENCIES += intelce-fw_load 
endif

define INTELCE_DEMUX_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_DEMUX_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_DEMUX_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
