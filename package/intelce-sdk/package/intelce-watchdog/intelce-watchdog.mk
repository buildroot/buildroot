################################################################################
#
# intelce-watchdog
#
################################################################################
INTELCE_WATCHDOG_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_WATCHDOG_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_WATCHDOG_SITE_METHOD = local
INTELCE_WATCHDOG_LICENSE = PROPRIETARY
INTELCE_WATCHDOG_REDISTRIBUTE = NO
INTELCE_WATCHDOG_DEPENDENCIES = intelce-sdk
INTELCE_WATCHDOG_INSTALL_STAGING = YES

INTELCE_WATCHDOG_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_WATCHDOG_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_WATCHDOG_CONFIGURE_CMDS
   
endef

define INTELCE_WATCHDOG_BUILD_CMDS
    if [ -d "${INTELCE_WATCHDOG_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_WATCHDOG_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_WATCHDOG_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_WATCHDOG_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_WATCHDOG_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_WATCHDOG_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_WATCHDOG_BUILD_ENV} ${INTELCESDK-BUILD} watchdog
endef

define INTELCE_WATCHDOG_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_WATCHDOG_DIR}/build_i686/staging_dir) 
endef

define INTELCE_WATCHDOG_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_WATCHDOG_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
