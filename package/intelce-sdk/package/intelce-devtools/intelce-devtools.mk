################################################################################
#
# intelce-devtools
#
################################################################################
INTELCE_DEVTOOLS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DEVTOOLS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_DEVTOOLS_SITE_METHOD = local
INTELCE_DEVTOOLS_LICENSE = PROPRIETARY
INTELCE_DEVTOOLS_REDISTRIBUTE = NO
INTELCE_DEVTOOLS_DEPENDENCIES = intelce-sdk linux openssl libnl
INTELCE_DEVTOOLS_INSTALL_STAGING = YES

INTELCE_DEVTOOLS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_DEVTOOLS_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    

define INTELCE_DEVTOOLS_BUILD_CMDS
    if [ -d "${INTELCE_DEVTOOLS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_DEVTOOLS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_DEVTOOLS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_DEVTOOLS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_DEVTOOLS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_DEVTOOLS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_DEVTOOLS_BUILD_ENV} ${INTELCESDK-BUILD} devtools
endef

define INTELCE_DEVTOOLS_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_DEVTOOLS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_DEVTOOLS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_DEVTOOLS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
