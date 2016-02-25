################################################################################
#
# intelce-cefdk
#
################################################################################
INTELCE_CEFDK_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_CEFDK_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_CEFDK_SITE_METHOD = local
INTELCE_CEFDK_LICENSE = PROPRIETARY
INTELCE_CEFDK_REDISTRIBUTE = NO
INTELCE_CEFDK_DEPENDENCIES = intelce-sdk intelce-flash_encryption_signing_tools
INTELCE_CEFDK_INSTALL_STAGING = YES

INTELCE_CEFDK_BUILD_ENV = \
	BUILD_TARGET_DIR=${INTELCE_CEFDK_DIR} \
	BUILD_SMD_COMMOM=false

define INTELCE_CEFDK_CONFIGURE_CMDS
endef

define INTELCE_CEFDK_BUILD_CMDS
	if [ -d "${INTELCE_CEFDK_DIR}/build_i686" ]; then \
		 rm -rf "${INTELCE_CEFDK_DIR}/build_i686"; \
	fi
	if [ -d "${INTELCE_CEFDK_DIR}/binaries" ]; then \
		 rm -rf "${INTELCE_CEFDK_DIR}/binaries"; \
	fi
	if [ -d "${INTELCE_CEFDK_DIR}/project_build_i686" ]; then \
		 rm -rf "${INTELCE_CEFDK_DIR}/project_build_i686"; \
	fi
	${INTELCE_CEFDK_BUILD_ENV} ${INTELCESDK-BUILD} cefdk
endef

define INTELCE_CEFDK_INSTALL_STAGING_CMDS
	$(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_CEFDK_DIR}/build_i686/staging_dir)
endef

define INTELCE_CEFDK_INSTALL_TARGET_CMDS
	$(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_CEFDK_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
