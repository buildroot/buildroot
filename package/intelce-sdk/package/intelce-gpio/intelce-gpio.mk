################################################################################
#
# intelce-gpio
#
################################################################################
INTELCE_GPIO_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GPIO_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_GPIO_SITE_METHOD = local
INTELCE_GPIO_LICENSE = PROPRIETARY
INTELCE_GPIO_REDISTRIBUTE = NO
INTELCE_GPIO_DEPENDENCIES = intelce-sdk linux
INTELCE_GPIO_INSTALL_STAGING = YES

INTELCE_GPIO_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GPIO_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_GPIO_CONFIGURE_CMDS
   
endef

define INTELCE_GPIO_BUILD_CMDS
    if [ -d "${INTELCE_GPIO_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_GPIO_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_GPIO_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_GPIO_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_GPIO_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_GPIO_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_GPIO_BUILD_ENV} ${INTELCESDK-BUILD} gpio
endef

define INTELCE_GPIO_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_GPIO_DIR}/build_i686/staging_dir)
endef

define INTELCE_GPIO_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_GPIO_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
