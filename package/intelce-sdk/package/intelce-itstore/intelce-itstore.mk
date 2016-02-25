################################################################################
#
# intelce-itstore
#
################################################################################
INTELCE_ITSTORE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_ITSTORE_SITE = ${INTELCE_SDK_DIR}/itstore
INTELCE_ITSTORE_SITE_METHOD = local
INTELCE_ITSTORE_LICENSE = PROPRIETARY
INTELCE_ITSTORE_REDISTRIBUTE = NO
INTELCE_ITSTORE_DEPENDENCIES = intelce-sdk intelce-sec intelce-osal
INTELCE_ITSTORE_INSTALL_STAGING = YES

define INTELCE_ITSTORE_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all 
endef

$(eval $(generic-package))
