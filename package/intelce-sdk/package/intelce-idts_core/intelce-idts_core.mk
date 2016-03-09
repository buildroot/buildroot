################################################################################
#
# intelce-idts_core
#
################################################################################
INTELCE_IDTS_CORE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTS_CORE_SITE = ${INTELCE_SDK_DIR}/idts_core
INTELCE_IDTS_CORE_SITE_METHOD = local
INTELCE_IDTS_CORE_LICENSE = PROPRIETARY
INTELCE_IDTS_CORE_REDISTRIBUTE = NO
INTELCE_IDTS_CORE_DEPENDENCIES = intelce-sdk intelce-common intelce-htuple intelce-pal intelce-osal intelce-idl intelce-api intelce-flashtool intelce-nand_config intelce-flash_appdata intelce-core intelce-clock intelce-clock_control intelce-clock_recovery intelce-demux intelce-sven intelce-platform_config intelce-auto_eas intelce-core intelce-idts_common linux intelce-mfhlib intelce-pwm intelce-system_utils intelce-idtsal
INTELCE_IDTS_CORE_INSTALL_STAGING = YES

define INTELCE_IDTS_CORE_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_IDTS_CORE_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_IDTS_CORE_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef
$(eval $(generic-package))
