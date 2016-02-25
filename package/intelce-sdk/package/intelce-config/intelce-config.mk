################################################################################
#
# intelce-config
#
################################################################################
INTELCE_CONFIG_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CONFIG_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_CONFIG_SITE_METHOD = local
INTELCE_CONFIG_LICENSE = PROPRIETARY
INTELCE_CONFIG_REDISTRIBUTE = NO
INTELCE_CONFIG_DEPENDENCIES = intelce-sdk
INTELCE_CONFIG_INSTALL_STAGING = YES

INTELCE_CONFIG_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_CONFIG_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_CONFIG_CONFIGURE_CMDS
   
endef

define INTELCE_CONFIG_BUILD_CMDS
    if [ -d "${INTELCE_CONFIG_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_CONFIG_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_CONFIG_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_CONFIG_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_CONFIG_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_CONFIG_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_CONFIG_BUILD_ENV} ${INTELCESDK-BUILD} config
endef

define INTELCE_CONFIG_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_CONFIG_DIR}/build_i686/staging_dir) 
endef

define INTELCE_CONFIG_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_CONFIG_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
