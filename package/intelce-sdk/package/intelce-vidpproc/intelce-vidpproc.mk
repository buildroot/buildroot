################################################################################
#
# intelce-vidpproc
#
################################################################################
INTELCE_VIDPPROC_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_VIDPPROC_SITE = ${INTELCE_SDK_DIR}/vidpproc
INTELCE_VIDPPROC_SITE_METHOD = local
INTELCE_VIDPPROC_LICENSE = PROPRIETARY
INTELCE_VIDPPROC_REDISTRIBUTE = NO
INTELCE_VIDPPROC_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-vidpproc_fw intelce-platform_config intelce-intel_ce_pm

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_VIDPPROC_DEPENDENCIES += intelce-fw_load 
endif

INTELCE_VIDPPROC_INSTALL_STAGING = YES

define INTELCE_VIDPPROC_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

define INTELCE_VIDPPROC_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_VIDPPROC_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target 
endef

$(eval $(generic-package))
