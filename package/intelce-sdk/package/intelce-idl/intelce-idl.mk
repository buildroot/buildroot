################################################################################
#
# intelce-idl
#
################################################################################
INTELCE_IDL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDL_SITE = ${INTELCE_SDK_DIR}/idl
INTELCE_IDL_SITE_METHOD = local
INTELCE_IDL_LICENSE = PROPRIETARY
INTELCE_IDL_REDISTRIBUTE = NO
INTELCE_IDL_INSTALL_STAGING = YES
INTELCE_IDL_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal 

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
INTELCE_IDL_DEPENDENCIES += intelce-gpio 
endif

define INTELCE_IDL_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_IDL_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev 
endef

define INTELCE_IDL_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target
endef

$(eval $(generic-package))
