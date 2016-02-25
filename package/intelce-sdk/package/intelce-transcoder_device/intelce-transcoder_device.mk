################################################################################
#
# intelce-transcoder_device
#
################################################################################
INTELCE_TRANSCODER_DEVICE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_TRANSCODER_DEVICE_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_TRANSCODER_DEVICE_SITE_METHOD = local
INTELCE_TRANSCODER_DEVICE_LICENSE = PROPRIETARY
INTELCE_TRANSCODER_DEVICE_REDISTRIBUTE = NO
INTELCE_TRANSCODER_DEVICE_DEPENDENCIES = intelce-sdk linux intelce-api intelce-osal intelce-SMD_Common intelce-smd_tools intelce-core intelce-htuple intelce-system_utils intelce-transcoder_common intelce-sec intelce-keyrefresh intelce-platform_config
INTELCE_TRANSCODER_DEVICE_INSTALL_STAGING = YES

INTELCE_TRANSCODER_DEVICE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_TRANSCODER_DEVICE_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_TRANSCODER_DEVICE_CONFIGURE_CMDS
   
endef

define INTELCE_TRANSCODER_DEVICE_BUILD_CMDS
    if [ -d "${INTELCE_TRANSCODER_DEVICE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_DEVICE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_TRANSCODER_DEVICE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_DEVICE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_TRANSCODER_DEVICE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_TRANSCODER_DEVICE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_TRANSCODER_DEVICE_BUILD_ENV} ${INTELCESDK-BUILD} transcoder_device
endef

define INTELCE_TRANSCODER_DEVICE_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_TRANSCODER_DEVICE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_TRANSCODER_DEVICE_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_TRANSCODER_DEVICE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
