################################################################################
#
# intelce-punit_fw_upgrade
#
################################################################################
INTELCE_PUNIT_FW_UPGRADE_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_PUNIT_FW_UPGRADE_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_PUNIT_FW_UPGRADE_SITE_METHOD = local
INTELCE_PUNIT_FW_UPGRADE_LICENSE = PROPRIETARY
INTELCE_PUNIT_FW_UPGRADE_REDISTRIBUTE = NO
INTELCE_PUNIT_FW_UPGRADE_DEPENDENCIES = intelce-sdk linux intelce-pal
INTELCE_PUNIT_FW_UPGRADE_INSTALL_STAGING = YES

ifeq ($(BR2_PACKAGE_INTELCE_SDK_V36),y)
    INTELCE_AUDIO_DEPENDENCIES +=  intelce-iosf
endif

INTELCE_PUNIT_FW_UPGRADE_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_PUNIT_FW_UPGRADE_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_PUNIT_FW_UPGRADE_CONFIGURE_CMDS
   
endef

define INTELCE_PUNIT_FW_UPGRADE_BUILD_CMDS
    if [ -d "${INTELCE_PUNIT_FW_UPGRADE_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_PUNIT_FW_UPGRADE_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_PUNIT_FW_UPGRADE_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_PUNIT_FW_UPGRADE_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_PUNIT_FW_UPGRADE_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_PUNIT_FW_UPGRADE_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_PUNIT_FW_UPGRADE_BUILD_ENV} ${INTELCESDK-BUILD} punit_fw_upgrade
endef

define INTELCE_PUNIT_FW_UPGRADE_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_PUNIT_FW_UPGRADE_DIR}/build_i686/staging_dir) 
endef

define INTELCE_PUNIT_FW_UPGRADE_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_PUNIT_FW_UPGRADE_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
