################################################################################
#
# intelce-cosai
#
################################################################################
INTELCE_COSAI_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_COSAI_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_COSAI_SITE_METHOD = local
INTELCE_COSAI_LICENSE = PROPRIETARY
INTELCE_COSAI_REDISTRIBUTE = NO
INTELCE_COSAI_DEPENDENCIES = intelce-sdk linux
INTELCE_COSAI_INSTALL_STAGING = YES

INTELCE_COSAI_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_COSAI_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_COSAI_CONFIGURE_CMDS
   
endef

define INTELCE_COSAI_BUILD_CMDS
    if [ -d "${INTELCE_COSAI_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_COSAI_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_COSAI_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_COSAI_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_COSAI_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_COSAI_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_COSAI_BUILD_ENV} ${INTELCESDK-BUILD} cosai
endef

define INTELCE_COSAI_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_COSAI_DIR}/build_i686/staging_dir) 
endef

define INTELCE_COSAI_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_COSAI_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
