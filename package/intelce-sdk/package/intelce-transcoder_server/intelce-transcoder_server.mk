################################################################################
#
# intelce-transcoder_server
#
################################################################################
INTELCE_TRANSCODER_SERVER_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_TRANSCODER_SERVER_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_TRANSCODER_SERVER_SITE_METHOD = local
INTELCE_TRANSCODER_SERVER_LICENSE = PROPRIETARY
INTELCE_TRANSCODER_SERVER_REDISTRIBUTE = NO
INTELCE_TRANSCODER_SERVER_DEPENDENCIES = intelce-sdk linux intelce-SMD_Common intelce-transcoder_common intelce-transcoder_pipeline
INTELCE_TRANSCODER_SERVER_INSTALL_STAGING = YES

INTELCE_TRANSCODER_SERVER_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_TRANSCODER_SERVER_DIR} \
    BUILD_SMD_COMMOM=true 
    
define INTELCE_TRANSCODER_SERVER_CONFIGURE_CMDS
   
endef

define INTELCE_TRANSCODER_SERVER_BUILD_CMDS
    if [ -d "${INTELCE_TRANSCODER_SERVER_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_SERVER_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_TRANSCODER_SERVER_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_SERVER_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_TRANSCODER_SERVER_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_SERVER_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_TRANSCODER_SERVER_BUILD_ENV} ${INTELCESDK-BUILD} transcoder_server
endef

define INTELCE_TRANSCODER_SERVER_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_TRANSCODER_SERVER_DIR}/build_i686/staging_dir) 
endef

define INTELCE_TRANSCODER_SERVER_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_TRANSCODER_SERVER_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
