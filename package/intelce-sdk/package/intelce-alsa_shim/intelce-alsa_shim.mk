################################################################################
#
# intelce-alsa_shim
#
################################################################################
INTELCE_ALSA_SHIM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_ALSA_SHIM_SITE = ${INTELCE_SDK_DIR}/alsa_shim
INTELCE_ALSA_SHIM_SITE_METHOD = local
INTELCE_ALSA_SHIM_LICENSE = PROPRIETARY
INTELCE_ALSA_SHIM_REDISTRIBUTE = NO
INTELCE_ALSA_SHIM_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-auto_eas intelce-audio intelce-auto_eas intelce-osal intelce-sven linux intelce-core intelce-SMD_Common intelce-api alsa-lib
INTELCE_ALSA_SHIM_INSTALL_STAGING = YES

define INTELCE_ALSA_SHIM_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_ALSA_SHIM_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

define INTELCE_ALSA_SHIM_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install
endef

$(eval $(generic-package))
