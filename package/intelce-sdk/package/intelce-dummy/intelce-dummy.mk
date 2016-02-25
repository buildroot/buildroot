################################################################################
#
# intelce-dummy
#
################################################################################
INTELCE_DUMMY_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DUMMY_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_DUMMY_SITE_METHOD = local
INTELCE_DUMMY_LICENSE = PROPRIETARY
INTELCE_DUMMY_REDISTRIBUTE = NO
INTELCE_DUMMY_DEPENDENCIES = intelce-sdk
INTELCE_DUMMY_INSTALL_STAGING = YES

INTELCE_DUMMY_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_DUMMY_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_DUMMY_CONFIGURE_CMDS
   
endef

define INTELCE_DUMMY_BUILD_CMDS
    if [ -d "${INTELCE_DUMMY_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_DUMMY_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_DUMMY_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_DUMMY_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_DUMMY_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_DUMMY_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_DUMMY_BUILD_ENV} ${INTELCESDK-BUILD} dummy
endef

define INTELCE_DUMMY_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_DUMMY_DIR}/build_i686/staging_dir) 
endef

define INTELCE_DUMMY_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_DUMMY_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
