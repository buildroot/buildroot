################################################################################
#
# intelce-pwm
#
################################################################################
INTELCE_PWM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PWM_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_PWM_SITE_METHOD = local
INTELCE_PWM_LICENSE = PROPRIETARY
INTELCE_PWM_REDISTRIBUTE = NO
INTELCE_PWM_DEPENDENCIES = intelce-sdk linux
INTELCE_PWM_INSTALL_STAGING = YES

INTELCE_PWM_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_PWM_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_PWM_CONFIGURE_CMDS
   
endef

define INTELCE_PWM_BUILD_CMDS
    if [ -d "${INTELCE_PWM_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_PWM_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_PWM_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_PWM_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_PWM_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_PWM_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_PWM_BUILD_ENV} ${INTELCESDK-BUILD} pwm
endef

define INTELCE_PWM_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_PWM_DIR}/build_i686/staging_dir) 
endef

define INTELCE_PWM_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_PWM_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
