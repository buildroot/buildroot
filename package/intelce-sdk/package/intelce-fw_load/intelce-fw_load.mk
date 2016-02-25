################################################################################
#
# intelce-fw_load
#
################################################################################
INTELCE_FW_LOAD_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_FW_LOAD_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_FW_LOAD_SITE_METHOD = local
INTELCE_FW_LOAD_LICENSE = PROPRIETARY
INTELCE_FW_LOAD_REDISTRIBUTE = NO
INTELCE_FW_LOAD_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-pal intelce-auto_eas intelce-osal intelce-htuple intelce-common intelce-smd_tools intelce-sven linux intelce-core intelce-api intelce-sec
INTELCE_FW_LOAD_INSTALL_STAGING = YES

INTELCE_FW_LOAD_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_FW_LOAD_DIR} \
    BUILD_SMD_COMMOM=true \
    BUILD_SMD_TOOLS=true  
    
define INTELCE_FW_LOAD_CONFIGURE_CMDS
   
endef

define INTELCE_FW_LOAD_BUILD_CMDS
    if [ -d "${INTELCE_FW_LOAD_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_FW_LOAD_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_FW_LOAD_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_FW_LOAD_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_FW_LOAD_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_FW_LOAD_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_FW_LOAD_BUILD_ENV} ${INTELCESDK-BUILD} fw_load
endef

define INTELCE_FW_LOAD_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_FW_LOAD_DIR}/build_i686/staging_dir) 
endef

define INTELCE_FW_LOAD_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_FW_LOAD_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
