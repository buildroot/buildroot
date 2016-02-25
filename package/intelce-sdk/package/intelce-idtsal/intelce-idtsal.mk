################################################################################
#
# intelce-idtsal
#
################################################################################
INTELCE_IDTSAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTSAL_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_IDTSAL_SITE_METHOD = local
INTELCE_IDTSAL_LICENSE = PROPRIETARY
INTELCE_IDTSAL_REDISTRIBUTE = NO
INTELCE_IDTSAL_DEPENDENCIES = intelce-sdk linux
INTELCE_IDTSAL_INSTALL_STAGING = YES

INTELCE_IDTSAL_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_IDTSAL_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_IDTSAL_CONFIGURE_CMDS
   
endef

define INTELCE_IDTSAL_BUILD_CMDS
    if [ -d "${INTELCE_IDTSAL_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_IDTSAL_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_IDTSAL_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_IDTSAL_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_IDTSAL_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_IDTSAL_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_IDTSAL_BUILD_ENV} ${INTELCESDK-BUILD} idtsal
endef

define INTELCE_IDTSAL_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_IDTSAL_DIR}/build_i686/staging_dir) 
endef

define INTELCE_IDTSAL_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_IDTSAL_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
