################################################################################
#
# intelce-alsa
#
################################################################################
INTELCE_ALSA_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_ALSA_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_ALSA_SITE_METHOD = local
INTELCE_ALSA_LICENSE = PROPRIETARY
INTELCE_ALSA_REDISTRIBUTE = NO
INTELCE_ALSA_DEPENDENCIES = intelce-sdk linux
INTELCE_ALSA_INSTALL_STAGING = YES

INTELCE_ALSA_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_ALSA_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_ALSA_CONFIGURE_CMDS
   
endef

define INTELCE_ALSA_BUILD_CMDS
    if [ -d "${INTELCE_ALSA_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_ALSA_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_ALSA_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_ALSA_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_ALSA_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_ALSA_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_ALSA_BUILD_ENV} ${INTELCESDK-BUILD} alsa
endef

define INTELCE_ALSA_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_ALSA_DIR}/build_i686/staging_dir) 
endef

define INTELCE_ALSA_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_ALSA_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
