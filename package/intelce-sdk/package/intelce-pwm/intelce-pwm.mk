################################################################################
#
# intelce-pwm
#
################################################################################
INTELCE_PWM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PWM_SITE = ${INTELCE_SDK_DIR}/pwm
INTELCE_PWM_SITE_METHOD = local
INTELCE_PWM_LICENSE = PROPRIETARY
INTELCE_PWM_REDISTRIBUTE = NO
INTELCE_PWM_DEPENDENCIES = intelce-sdk linux
INTELCE_PWM_INSTALL_STAGING = YES

define INTELCE_PWM_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_PWM_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_PWM_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
