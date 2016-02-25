################################################################################
#
# intelce-graphics_apps
#
################################################################################
INTELCE_GRAPHICS_APPS_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GRAPHICS_APPS_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_GRAPHICS_APPS_SITE_METHOD = local
INTELCE_GRAPHICS_APPS_LICENSE = PROPRIETARY
INTELCE_GRAPHICS_APPS_REDISTRIBUTE = NO
INTELCE_GRAPHICS_APPS_DEPENDENCIES = intelce-sdk intelce-graphics intelce-osal intelce-pal intelce-display intelce-jpeg intelce-smd_sample_apps
INTELCE_GRAPHICS_APPS_INSTALL_STAGING = YES

INTELCE_GRAPHICS_APPS_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GRAPHICS_APPS_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_GRAPHICS_APPS_CONFIGURE_CMDS
   
endef

define INTELCE_GRAPHICS_APPS_BUILD_CMDS
    if [ -d "${INTELCE_GRAPHICS_APPS_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_APPS_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_GRAPHICS_APPS_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_APPS_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_GRAPHICS_APPS_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_APPS_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_GRAPHICS_APPS_BUILD_ENV} ${INTELCESDK-BUILD} graphics_apps
endef

define INTELCE_GRAPHICS_APPS_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_GRAPHICS_APPS_DIR}/build_i686/staging_dir) 
endef

define INTELCE_GRAPHICS_APPS_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_GRAPHICS_APPS_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
