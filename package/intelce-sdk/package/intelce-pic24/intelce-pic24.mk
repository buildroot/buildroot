################################################################################
#
# intelce-pic24
#
################################################################################
INTELCE_PIC24_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PIC24_SITE = ${INTELCE_SDK_DIR}/pic24
INTELCE_PIC24_SITE_METHOD = local
INTELCE_PIC24_LICENSE = PROPRIETARY
INTELCE_PIC24_REDISTRIBUTE = NO
INTELCE_PIC24_DEPENDENCIES = intelce-sdk
INTELCE_PIC24_INSTALL_STAGING = YES

define INTELCE_PIC24_BUILD_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) all
endef

define INTELCE_PIC24_INSTALL_STAGING_CMDS
    $(INTELCE_SDK_MAKE_ENV) $(MAKE) ${INTELCE_SDK_MAKE_OPTS} -C $(@D) install 
endef


$(eval $(generic-package))
