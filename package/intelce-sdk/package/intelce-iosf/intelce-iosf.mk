################################################################################
#
# intelce-iosf
#
################################################################################
INTELCE_IOSF_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IOSF_SITE = ${INTELCE_SDK_DIR}/iosf
INTELCE_IOSF_SITE_METHOD = local
INTELCE_IOSF_LICENSE = PROPRIETARY
INTELCE_IOSF_REDISTRIBUTE = NO
INTELCE_IOSF_DEPENDENCIES = intelce-sdk linux
INTELCE_IOSF_INSTALL_STAGING = YES

define INTELCE_IOSF_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_IOSF_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_dev
endef

define INTELCE_IOSF_INSTALL_TARGET_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install_target    
endef

$(eval $(generic-package))
