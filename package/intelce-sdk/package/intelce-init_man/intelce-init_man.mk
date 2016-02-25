################################################################################
#
# intelce-init_man
#
################################################################################
INTELCE_INIT_MAN_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_INIT_MAN_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_INIT_MAN_SITE_METHOD = local
INTELCE_INIT_MAN_LICENSE = PROPRIETARY
INTELCE_INIT_MAN_REDISTRIBUTE = NO
INTELCE_INIT_MAN_DEPENDENCIES = intelce-sdk
INTELCE_INIT_MAN_INSTALL_STAGING = YES

INTELCE_INIT_MAN_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_INIT_MAN_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_INIT_MAN_CONFIGURE_CMDS
   
endef

define INTELCE_INIT_MAN_BUILD_CMDS
    if [ -d "${INTELCE_INIT_MAN_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_INIT_MAN_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_INIT_MAN_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_INIT_MAN_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_INIT_MAN_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_INIT_MAN_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_INIT_MAN_BUILD_ENV} ${INTELCESDK-BUILD} init_man
endef

define INTELCE_INIT_MAN_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_INIT_MAN_DIR}/build_i686/staging_dir) 
endef

define INTELCE_INIT_MAN_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_INIT_MAN_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
