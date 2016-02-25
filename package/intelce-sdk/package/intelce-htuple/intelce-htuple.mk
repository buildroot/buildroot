################################################################################
#
# intelce-htuple
#
################################################################################
INTELCE_HTUPLE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_HTUPLE_SITE = ${INTELCE_SDK_DIR}/htuple
INTELCE_HTUPLE_SITE_METHOD = local
INTELCE_HTUPLE_LICENSE = PROPRIETARY
INTELCE_HTUPLE_REDISTRIBUTE = NO
INTELCE_HTUPLE_DEPENDENCIES = intelce-sdk linux intelce-SMD_Common
INTELCE_HTUPLE_INSTALL_STAGING = YES

define INTELCE_HTUPLE_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_HTUPLE_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_HTUPLE_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
