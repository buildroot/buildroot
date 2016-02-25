################################################################################
#
# intelce-auto_eas
#
################################################################################
INTELCE_AUTO_EAS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AUTO_EAS_SITE = ${INTELCE_SDK_DIR}/auto_eas
INTELCE_AUTO_EAS_SITE_METHOD = local
INTELCE_AUTO_EAS_LICENSE = PROPRIETARY
INTELCE_AUTO_EAS_REDISTRIBUTE = NO
INTELCE_AUTO_EAS_DEPENDENCIES = intelce-sdk intelce-SMD_Common linux
INTELCE_AUTO_EAS_INSTALL_STAGING = YES

define INTELCE_AUTO_EAS_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_AUTO_EAS_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_AUTO_EAS_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
