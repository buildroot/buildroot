################################################################################
#
# intelce-alsa_shim
#
################################################################################
INTELCE_ALSA_SHIM_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_ALSA_SHIM_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_ALSA_SHIM_SITE_METHOD = local
INTELCE_ALSA_SHIM_LICENSE = PROPRIETARY
INTELCE_ALSA_SHIM_REDISTRIBUTE = NO
INTELCE_ALSA_SHIM_DEPENDENCIES = intelce-sdk intelce-system_utils intelce-auto_eas intelce-audio intelce-auto_eas intelce-osal intelce-sven linux intelce-core intelce-SMD_Common intelce-api intelce-alsa
INTELCE_ALSA_SHIM_INSTALL_STAGING = YES

INTELCE_ALSA_SHIM_BUILD_ENV = \
	BUILD_TARGET_DIR=${INTELCE_ALSA_SHIM_DIR} \
	BUILD_SMD_COMMOM=true

define INTELCE_ALSA_SHIM_CONFIGURE_CMDS
endef

define INTELCE_ALSA_SHIM_BUILD_CMDS
	if [ -d "${INTELCE_ALSA_SHIM_DIR}/build_i686" ]; then \
		 rm -rf "${INTELCE_ALSA_SHIM_DIR}/build_i686"; \
	fi
	if [ -d "${INTELCE_ALSA_SHIM_DIR}/binaries" ] ; then \
		 rm -rf "${INTELCE_ALSA_SHIM_DIR}/binaries"; \
	fi
	if [ -d "${INTELCE_ALSA_SHIM_DIR}/project_build_i686" ]; then \
		 rm -rf "${INTELCE_ALSA_SHIM_DIR}/project_build_i686"; \
	fi
	${INTELCE_ALSA_SHIM_BUILD_ENV} ${INTELCESDK-BUILD} alsa_shim
endef

define INTELCE_ALSA_SHIM_INSTALL_STAGING_CMDS
	$(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_ALSA_SHIM_DIR}/build_i686/staging_dir) 
endef

define INTELCE_ALSA_SHIM_INSTALL_TARGET_CMDS
	$(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_ALSA_SHIM_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
