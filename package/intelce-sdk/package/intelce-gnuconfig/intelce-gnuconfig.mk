################################################################################
#
# intelce-gnuconfig
#
################################################################################
INTELCE_GNUCONFIG_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GNUCONFIG_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_GNUCONFIG_SITE_METHOD = local
INTELCE_GNUCONFIG_LICENSE = PROPRIETARY
INTELCE_GNUCONFIG_REDISTRIBUTE = NO
INTELCE_GNUCONFIG_DEPENDENCIES = intelce-sdk
INTELCE_GNUCONFIG_INSTALL_STAGING = YES

INTELCE_GNUCONFIG_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GNUCONFIG_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_GNUCONFIG_CONFIGURE_CMDS
   
endef

define INTELCE_GNUCONFIG_BUILD_CMDS
    if [ -d "${INTELCE_GNUCONFIG_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_GNUCONFIG_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_GNUCONFIG_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_GNUCONFIG_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_GNUCONFIG_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_GNUCONFIG_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_GNUCONFIG_BUILD_ENV} ${INTELCESDK-BUILD} gnuconfig
endef

define INTELCE_GNUCONFIG_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_GNUCONFIG_DIR}/build_i686/staging_dir) 
endef

define INTELCE_GNUCONFIG_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_GNUCONFIG_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
