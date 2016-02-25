################################################################################
#
# intelce-freedesktop
#
################################################################################
INTELCE_FREEDESKTOP_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_FREEDESKTOP_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_FREEDESKTOP_SITE_METHOD = local
INTELCE_FREEDESKTOP_LICENSE = PROPRIETARY
INTELCE_FREEDESKTOP_REDISTRIBUTE = NO
INTELCE_FREEDESKTOP_DEPENDENCIES = intelce-sdk linux openssl 
INTELCE_FREEDESKTOP_INSTALL_STAGING = YES

INTELCE_FREEDESKTOP_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_FREEDESKTOP_DIR} \
    BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true  
    
define INTELCE_FREEDESKTOP_CONFIGURE_CMDS
   cp ${STAGING_DIR}/usr/lib/libfreetype.la ${INTELCE_SDK_DIR}/build_i686/staging_dir/lib/libfreetype.la
   cp ${STAGING_DIR}/usr/lib/libfreetype.so ${INTELCE_SDK_DIR}/build_i686/staging_dir/lib/libfreetype.so
   mkdir -p ${INTELCE_SDK_DIR}/build_i686/staging_dir/usr/include/freetype2
   cp -r ${STAGING_DIR}/usr/include/freetype2/* ${INTELCE_SDK_DIR}/build_i686/staging_dir/usr/include/freetype2
   cp ${STAGING_DIR}/usr/lib/pkgconfig/freetype2.pc ${INTELCE_SDK_DIR}/build_i686/staging_dir/lib/pkgconfig/freetype2.pc
endef

define INTELCE_FREEDESKTOP_BUILD_CMDS
    if [ -d "${INTELCE_FREEDESKTOP_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_FREEDESKTOP_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_FREEDESKTOP_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_FREEDESKTOP_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_FREEDESKTOP_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_FREEDESKTOP_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_FREEDESKTOP_BUILD_ENV} ${INTELCESDK-BUILD} freedesktop
endef

define INTELCE_FREEDESKTOP_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_FREEDESKTOP_DIR}/build_i686/staging_dir) 
endef

define INTELCE_FREEDESKTOP_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_FREEDESKTOP_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
