################################################################################
#
# intelce-nsprpub_mw_dep
#
################################################################################
INTELCE_NSPRPUB_MW_DEP_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_NSPRPUB_MW_DEP_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_NSPRPUB_MW_DEP_SITE_METHOD = local
INTELCE_NSPRPUB_MW_DEP_LICENSE = PROPRIETARY
INTELCE_NSPRPUB_MW_DEP_REDISTRIBUTE = NO
INTELCE_NSPRPUB_MW_DEP_DEPENDENCIES = intelce-sdk intelce-nspr
INTELCE_NSPRPUB_MW_DEP_INSTALL_STAGING = YES

INTELCE_NSPRPUB_MW_DEP_BUILD_ENV = \
    BUILD_TARGET_DIR=${INTELCE_NSPRPUB_MW_DEP_DIR} \
    BUILD_SMD_COMMOM=false 
    
define INTELCE_NSPRPUB_MW_DEP_CONFIGURE_CMDS
   
endef

define INTELCE_NSPRPUB_MW_DEP_BUILD_CMDS
    if [ -d "${INTELCE_NSPRPUB_MW_DEP_DIR}/build_i686" ] ; then \
       rm -rf "${INTELCE_NSPRPUB_MW_DEP_DIR}/build_i686"; \
    fi

    if [ -d "${INTELCE_NSPRPUB_MW_DEP_DIR}/binaries" ] ; then \
       rm -rf "${INTELCE_NSPRPUB_MW_DEP_DIR}/binaries" ; \
    fi
    
    if [ -d "${INTELCE_NSPRPUB_MW_DEP_DIR}/project_build_i686" ] ; then \
       rm -rf "${INTELCE_NSPRPUB_MW_DEP_DIR}/project_build_i686" ; \
    fi
    
    ${INTELCE_NSPRPUB_MW_DEP_BUILD_ENV} ${INTELCESDK-BUILD} nsprpub_mw_dep
endef

define INTELCE_NSPRPUB_MW_DEP_INSTALL_STAGING_CMDS
    $(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_NSPRPUB_MW_DEP_DIR}/build_i686/staging_dir) 
endef

define INTELCE_NSPRPUB_MW_DEP_INSTALL_TARGET_CMDS
    $(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_NSPRPUB_MW_DEP_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
