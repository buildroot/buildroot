################################################################################
#
# intelce-sec_fw
#
################################################################################
INTELCE_SEC_FW_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_SEC_FW_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_SEC_FW_SITE_METHOD = local
INTELCE_SEC_FW_LICENSE = PROPRIETARY
INTELCE_SEC_FW_REDISTRIBUTE = NO
INTELCE_SEC_FW_DEPENDENCIES = intelce-sdk intelce-sec intelce-flash_appdata intelce-osal intelce-pal expat host-expat intelce-config_database
INTELCE_SEC_FW_INSTALL_STAGING = YES

INTELCE_SEC_FW_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_SEC_FW_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_SEC_FW_CONFIGURE_CMDS
   
endef

define INTELCE_SEC_FW_BUILD_CMDS
    if [ -d "${INTELCE_SEC_FW_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_SEC_FW_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_SEC_FW_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_SEC_FW_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_SEC_FW_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_SEC_FW_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_SEC_FW_BUILD_ENV} ${INTELCESDK-BUILD} sec_fw
endef

define INTELCE_SEC_FW_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_SEC_FW_DIR}/build_i686/staging_dir) 
endef

define INTELCE_SEC_FW_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_SEC_FW_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
