################################################################################
#
# intelce-alsa
#
################################################################################
INTELCE_ALSA_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_ALSA_SITE = ${INTELCE_SDK_DIR}/asla
INTELCE_ALSA_SITE_METHOD = local
INTELCE_ALSA_LICENSE = PROPRIETARY
INTELCE_ALSA_REDISTRIBUTE = NO
INTELCE_ALSA_DEPENDENCIES = intelce-sdk linux
INTELCE_ALSA_INSTALL_STAGING = YES

define INTELCE_ALSA_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_ALSA_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_ALSA_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
