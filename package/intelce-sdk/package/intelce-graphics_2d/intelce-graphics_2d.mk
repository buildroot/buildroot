################################################################################
#
# intelce-graphics_2d
#
################################################################################
INTELCE_GRAPHICS_2D_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_GRAPHICS_2D_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_GRAPHICS_2D_SITE_METHOD = local
INTELCE_GRAPHICS_2D_LICENSE = PROPRIETARY
INTELCE_GRAPHICS_2D_REDISTRIBUTE = NO
INTELCE_GRAPHICS_2D_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-platform_config intelce-display intelce-graphics intelce-system_utils
INTELCE_GRAPHICS_2D_INSTALL_STAGING = YES

INTELCE_GRAPHICS_2D_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_GRAPHICS_2D_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_GRAPHICS_2D_CONFIGURE_CMDS
   
endef

define INTELCE_GRAPHICS_2D_BUILD_CMDS
    if [ -d "${INTELCE_GRAPHICS_2D_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_2D_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_GRAPHICS_2D_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_2D_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_GRAPHICS_2D_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_GRAPHICS_2D_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_GRAPHICS_2D_BUILD_ENV} ${INTELCESDK-BUILD} graphics_2d
endef

define INTELCE_GRAPHICS_2D_INSTALL_STAGING_CMDS
    find ${INTELCE_GRAPHICS_2D_DIR} -name graphics_2d -type f -exec sed -i 's/INSTALL_GAL="no"/INSTALL_GAL="yes"/' {}  \;
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_GRAPHICS_2D_DIR}/build_i686/staging_dir) 
endef

define INTELCE_GRAPHICS_2D_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_GRAPHICS_2D_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
