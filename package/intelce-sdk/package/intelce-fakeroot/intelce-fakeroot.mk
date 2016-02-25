################################################################################
#
# intelce-fakeroot
#
################################################################################
INTELCE_FAKEROOT_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_FAKEROOT_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_FAKEROOT_SITE_METHOD = local
INTELCE_FAKEROOT_LICENSE = PROPRIETARY
INTELCE_FAKEROOT_REDISTRIBUTE = NO
INTELCE_FAKEROOT_DEPENDENCIES = intelce-sdk
INTELCE_FAKEROOT_INSTALL_STAGING = YES

INTELCE_FAKEROOT_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_FAKEROOT_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_FAKEROOT_CONFIGURE_CMDS
   
endef

define INTELCE_FAKEROOT_BUILD_CMDS
    if [ -d "${INTELCE_FAKEROOT_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_FAKEROOT_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_FAKEROOT_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_FAKEROOT_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_FAKEROOT_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_FAKEROOT_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_FAKEROOT_BUILD_ENV} ${INTELCESDK-BUILD} fakeroot
endef

define INTELCE_FAKEROOT_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_FAKEROOT_DIR}/build_i686/staging_dir) 
endef

define INTELCE_FAKEROOT_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_FAKEROOT_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
