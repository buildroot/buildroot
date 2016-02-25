################################################################################
#
# intelce-idts_core
#
################################################################################
INTELCE_IDTS_CORE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTS_CORE_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_IDTS_CORE_SITE_METHOD = local
INTELCE_IDTS_CORE_LICENSE = PROPRIETARY
INTELCE_IDTS_CORE_REDISTRIBUTE = NO
INTELCE_IDTS_CORE_DEPENDENCIES = intelce-sdk intelce-common intelce-htuple intelce-pal intelce-osal intelce-idl intelce-api intelce-flashtool intelce-nand_config intelce-flash_appdata intelce-core intelce-clock intelce-clock_control intelce-clock_recovery intelce-demux intelce-sven intelce-platform_config intelce-auto_eas intelce-core intelce-idts_common linux intelce-mfhlib intelce-pwm intelce-system_utils intelce-idtsal
INTELCE_IDTS_CORE_INSTALL_STAGING = YES

INTELCE_IDTS_CORE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_IDTS_CORE_DIR} \
    BUILD_SMD_COMMOM=false \
    BUILD_IDTS_COMMON=true 
    
define INTELCE_IDTS_CORE_CONFIGURE_CMDS
   
endef

define INTELCE_IDTS_CORE_BUILD_CMDS
    if [ -d "${INTELCE_IDTS_CORE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_CORE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_IDTS_CORE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_IDTS_CORE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_IDTS_CORE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_CORE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_IDTS_CORE_BUILD_ENV} ${INTELCESDK-BUILD} idts_core
endef

define INTELCE_IDTS_CORE_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_IDTS_CORE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_IDTS_CORE_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_IDTS_CORE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
