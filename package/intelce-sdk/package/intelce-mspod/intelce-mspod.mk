################################################################################
#
# intelce-mspod
#
################################################################################
INTELCE_MSPOD_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_MSPOD_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_MSPOD_SITE_METHOD = local
INTELCE_MSPOD_LICENSE = PROPRIETARY
INTELCE_MSPOD_REDISTRIBUTE = NO
INTELCE_MSPOD_DEPENDENCIES = intelce-sdk linux intelce-auto_eas intelce-osal intelce-idl intelce-flash_appdata intelce-sven intelce-core
INTELCE_MSPOD_INSTALL_STAGING = YES

INTELCE_MSPOD_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_MSPOD_DIR} \
    BUILD_SMD_COMMOM=false \
    MAKE_STAGING_LIB_DIR=true 
    
define INTELCE_MSPOD_CONFIGURE_CMDS
   
endef

define INTELCE_MSPOD_BUILD_CMDS
    if [ -d "${INTELCE_MSPOD_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_MSPOD_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_MSPOD_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_MSPOD_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_MSPOD_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_MSPOD_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_MSPOD_BUILD_ENV} ${INTELCESDK-BUILD} mspod
endef

define INTELCE_MSPOD_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_MSPOD_DIR}/build_i686/staging_dir) 
endef

define INTELCE_MSPOD_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_MSPOD_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
