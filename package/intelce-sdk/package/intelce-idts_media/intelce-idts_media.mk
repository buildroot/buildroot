################################################################################
#
# intelce-idts_media
#
################################################################################
INTELCE_IDTS_MEDIA_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_IDTS_MEDIA_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_IDTS_MEDIA_SITE_METHOD = local
INTELCE_IDTS_MEDIA_LICENSE = PROPRIETARY
INTELCE_IDTS_MEDIA_REDISTRIBUTE = NO
INTELCE_IDTS_MEDIA_DEPENDENCIES = intelce-sdk intelce-common intelce-htuple intelce-pal intelce-osal intelce-idl intelce-api intelce-flashtool intelce-nand_config intelce-flash_appdata intelce-pic24_uart intelce-pic24_uart_drv intelce-sec intelce-display intelce-core intelce-clock intelce-clock_control intelce-clock_recovery intelce-bufmon intelce-audio intelce-demux intelce-remux intelce-viddec intelce-sven intelce-vidpproc intelce-display intelce-SMD_Common intelce-vidrend intelce-platform_config intelce-auto_eas intelce-core intelce-graphics intelce-smd_sample_apps intelce-smd_tools intelce-DirectFB_1_6 intelce-idts_common linux intelce-mfhlib intelce-pwm intelce-system_utils intelce-idtsal
INTELCE_IDTS_MEDIA_INSTALL_STAGING = YES

INTELCE_IDTS_MEDIA_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_IDTS_MEDIA_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_IDTS_MEDIA_CONFIGURE_CMDS
   
endef

define INTELCE_IDTS_MEDIA_BUILD_CMDS
    if [ -d "${INTELCE_IDTS_MEDIA_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_MEDIA_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_IDTS_MEDIA_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_IDTS_MEDIA_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_IDTS_MEDIA_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_IDTS_MEDIA_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_IDTS_MEDIA_BUILD_ENV} ${INTELCESDK-BUILD} idts_media
endef

define INTELCE_IDTS_MEDIA_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_IDTS_MEDIA_DIR}/build_i686/staging_dir) 
endef

define INTELCE_IDTS_MEDIA_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_IDTS_MEDIA_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
