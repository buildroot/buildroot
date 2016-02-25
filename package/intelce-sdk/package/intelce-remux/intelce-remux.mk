################################################################################
#
# intelce-remux
#
################################################################################
INTELCE_REMUX_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_REMUX_SITE = ${INTELCE_SDK_DIR}/remux
INTELCE_REMUX_SITE_METHOD = local
INTELCE_REMUX_LICENSE = PROPRIETARY
INTELCE_REMUX_REDISTRIBUTE = NO
INTELCE_REMUX_DEPENDENCIES = intelce-sdk intelce-api intelce-core intelce-pal intelce-osal intelce-auto_eas intelce-sven intelce-htuple intelce-system_utils intelce-platform_config intelce-common intelce-smd_tools linux intelce-SMD_Common
INTELCE_REMUX_INSTALL_STAGING = YES


define INTELCE_REMUX_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_REMUX_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_REMUX_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
