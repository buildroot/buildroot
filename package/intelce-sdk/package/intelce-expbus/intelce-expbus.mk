################################################################################
#
# intelce-expbus
#
################################################################################
INTELCE_EXPBUS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_EXPBUS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_EXPBUS_SITE_METHOD = local
INTELCE_EXPBUS_LICENSE = PROPRIETARY
INTELCE_EXPBUS_REDISTRIBUTE = NO
INTELCE_EXPBUS_DEPENDENCIES = intelce-sdk linux
INTELCE_EXPBUS_INSTALL_STAGING = YES

INTELCE_EXPBUS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_EXPBUS_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_EXPBUS_CONFIGURE_CMDS
   
endef

define INTELCE_EXPBUS_BUILD_CMDS
    if [ -d "${INTELCE_EXPBUS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_EXPBUS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_EXPBUS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_EXPBUS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_EXPBUS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_EXPBUS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_EXPBUS_BUILD_ENV} ${INTELCESDK-BUILD} expbus
endef

define INTELCE_EXPBUS_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_EXPBUS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_EXPBUS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_EXPBUS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
