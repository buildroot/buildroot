################################################################################
#
# intelce-DirectFB_1_4
#
################################################################################
INTELCE_DIRECTFB_1_4_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_DIRECTFB_1_4_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_DIRECTFB_1_4_SITE_METHOD = local
INTELCE_DIRECTFB_1_4_LICENSE = PROPRIETARY
INTELCE_DIRECTFB_1_4_REDISTRIBUTE = NO
INTELCE_DIRECTFB_1_4_DEPENDENCIES = intelce-sdk linux intelce-osal intelce-pal intelce-platform_config intelce-idl intelce-display intelce-graphics intelce-system_utils
INTELCE_DIRECTFB_1_4_INSTALL_STAGING = YES

INTELCE_DIRECTFB_1_4_BUILD_ENV = \
	BUILD_TARGET_DIR=${INTELCE_DIRECTFB_1_4_DIR} \
	BUILD_SMD_COMMOM=true BUILD_SMD_TOOLS=true

define INTELCE_DIRECTFB_1_4_CONFIGURE_CMDS
endef

define INTELCE_DIRECTFB_1_4_BUILD_CMDS
	if [ -d "${INTELCE_DIRECTFB_1_4_DIR}/build_i686" ]; then \
		 rm -rf "${INTELCE_DIRECTFB_1_4_DIR}/build_i686"; \
	fi
	if [ -d "${INTELCE_DIRECTFB_1_4_DIR}/binaries" ]; then \
		 rm -rf "${INTELCE_DIRECTFB_1_4_DIR}/binaries"; \
	fi
	if [ -d "${INTELCE_DIRECTFB_1_4_DIR}/project_build_i686" ]; then \
		 rm -rf "${INTELCE_DIRECTFB_1_4_DIR}/project_build_i686"; \
	fi
	${INTELCE_DIRECTFB_1_4_BUILD_ENV} ${INTELCESDK-BUILD} DirectFB_1_4
endef

define INTELCE_DIRECTFB_1_4_INSTALL_STAGING_CMDS
	$(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_DIRECTFB_1_4_DIR}/build_i686/staging_dir) 
endef

define INTELCE_DIRECTFB_1_4_INSTALL_TARGET_CMDS
	$(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_DIRECTFB_1_4_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
