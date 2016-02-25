################################################################################
#
# intelce-thermal
#
################################################################################
INTELCE_THERMAL_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_THERMAL_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_THERMAL_SITE_METHOD = local
INTELCE_THERMAL_LICENSE = PROPRIETARY
INTELCE_THERMAL_REDISTRIBUTE = NO
INTELCE_THERMAL_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal
INTELCE_THERMAL_INSTALL_STAGING = YES

INTELCE_THERMAL_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_THERMAL_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_THERMAL_CONFIGURE_CMDS
   
endef

define INTELCE_THERMAL_BUILD_CMDS
    if [ -d "${INTELCE_THERMAL_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_THERMAL_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_THERMAL_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_THERMAL_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_THERMAL_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_THERMAL_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_THERMAL_BUILD_ENV} ${INTELCESDK-BUILD} thermal
endef

define INTELCE_THERMAL_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_THERMAL_DIR}/build_i686/staging_dir) 
endef

define INTELCE_THERMAL_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_THERMAL_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
