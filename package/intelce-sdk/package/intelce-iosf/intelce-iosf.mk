################################################################################
#
# intelce-iosf
#
################################################################################
INTELCE_IOSF_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IOSF_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_IOSF_SITE_METHOD = local
INTELCE_IOSF_LICENSE = PROPRIETARY
INTELCE_IOSF_REDISTRIBUTE = NO
INTELCE_IOSF_DEPENDENCIES = intelce-sdk linux
INTELCE_IOSF_INSTALL_STAGING = YES

INTELCE_IOSF_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_IOSF_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_IOSF_CONFIGURE_CMDS
   
endef

define INTELCE_IOSF_BUILD_CMDS
    if [ -d "${INTELCE_IOSF_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_IOSF_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_IOSF_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_IOSF_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_IOSF_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_IOSF_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_IOSF_BUILD_ENV} ${INTELCESDK-BUILD} iosf
endef

define INTELCE_IOSF_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_IOSF_DIR}/build_i686/staging_dir) 
endef

define INTELCE_IOSF_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_IOSF_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
