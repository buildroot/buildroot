################################################################################
#
# intelce-idtsal
#
################################################################################
INTELCE_IDTSAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTSAL_SITE = ${INTELCE_SDK_DIR}/idtsal
INTELCE_IDTSAL_SITE_METHOD = local
INTELCE_IDTSAL_LICENSE = PROPRIETARY
INTELCE_IDTSAL_REDISTRIBUTE = NO
INTELCE_IDTSAL_DEPENDENCIES = intelce-sdk linux
INTELCE_IDTSAL_INSTALL_STAGING = YES


define INTELCE_IDTSAL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_IDTSAL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_IDTSAL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target    
endef

$(eval $(generic-package))
