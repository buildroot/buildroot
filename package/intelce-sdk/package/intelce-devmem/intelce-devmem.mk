################################################################################
#
# intelce-devmem
#
################################################################################
INTELCE_DEVMEM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DEVMEM_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_DEVMEM_SITE_METHOD = local
INTELCE_DEVMEM_LICENSE = PROPRIETARY
INTELCE_DEVMEM_REDISTRIBUTE = NO
INTELCE_DEVMEM_DEPENDENCIES = intelce-sdk linux intelce-platform_config
INTELCE_DEVMEM_INSTALL_STAGING = YES

INTELCE_DEVMEM_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_DEVMEM_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_DEVMEM_CONFIGURE_CMDS
   
endef

define INTELCE_DEVMEM_BUILD_CMDS
    if [ -d "${INTELCE_DEVMEM_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_DEVMEM_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_DEVMEM_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_DEVMEM_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_DEVMEM_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_DEVMEM_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_DEVMEM_BUILD_ENV} ${INTELCESDK-BUILD} devmem
endef

define INTELCE_DEVMEM_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_DEVMEM_DIR}/build_i686/staging_dir) 
endef

define INTELCE_DEVMEM_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_DEVMEM_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
