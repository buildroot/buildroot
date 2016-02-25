################################################################################
#
# intelce-keyrefresh
#
################################################################################
INTELCE_KEYREFRESH_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_KEYREFRESH_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_KEYREFRESH_SITE_METHOD = local
INTELCE_KEYREFRESH_LICENSE = PROPRIETARY
INTELCE_KEYREFRESH_REDISTRIBUTE = NO
INTELCE_KEYREFRESH_DEPENDENCIES = intelce-sdk intelce-sec
INTELCE_KEYREFRESH_INSTALL_STAGING = YES

INTELCE_KEYREFRESH_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_KEYREFRESH_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_KEYREFRESH_CONFIGURE_CMDS
   
endef

define INTELCE_KEYREFRESH_BUILD_CMDS
    if [ -d "${INTELCE_KEYREFRESH_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_KEYREFRESH_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_KEYREFRESH_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_KEYREFRESH_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_KEYREFRESH_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_KEYREFRESH_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_KEYREFRESH_BUILD_ENV} ${INTELCESDK-BUILD} keyrefresh
endef

define INTELCE_KEYREFRESH_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_KEYREFRESH_DIR}/build_i686/staging_dir) 
endef

define INTELCE_KEYREFRESH_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_KEYREFRESH_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
