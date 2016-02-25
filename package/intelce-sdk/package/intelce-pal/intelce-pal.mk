################################################################################
#
# intelce-pal
#
################################################################################
INTELCE_PAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PAL_SITE = ${INTELCE_SDK_DIR}/pal
INTELCE_PAL_SITE_METHOD = local
INTELCE_PAL_LICENSE = PROPRIETARY
INTELCE_PAL_REDISTRIBUTE = NO
INTELCE_PAL_DEPENDENCIES = intelce-sdk linux intelce-SMD_Common intelce-osal intelce-auto_eas
INTELCE_PAL_INSTALL_STAGING = YES

define INTELCE_PAL_CONFIGURE_CMDS
   
endef

define INTELCE_PAL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_PAL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_PAL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
