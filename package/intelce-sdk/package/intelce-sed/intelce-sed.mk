################################################################################
#
# intelce-sed
#
################################################################################
INTELCE_SED_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SED_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_SED_SITE_METHOD = local
INTELCE_SED_LICENSE = PROPRIETARY
INTELCE_SED_REDISTRIBUTE = NO
INTELCE_SED_DEPENDENCIES = intelce-sdk
INTELCE_SED_INSTALL_STAGING = YES

INTELCE_SED_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SED_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_SED_CONFIGURE_CMDS
   
endef

define INTELCE_SED_BUILD_CMDS
    if [ -d "${INTELCE_SED_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SED_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SED_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SED_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SED_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SED_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SED_BUILD_ENV} ${INTELCESDK-BUILD} sed
endef

define INTELCE_SED_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_SED_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SED_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_SED_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
