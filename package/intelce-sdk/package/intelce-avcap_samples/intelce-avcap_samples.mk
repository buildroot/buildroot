################################################################################
#
# intelce-avcap_samples
#
################################################################################
INTELCE_AVCAP_SAMPLES_VERSION = ${INTELCE_SDK_VERSION}
INTELCE_AVCAP_SAMPLES_SITE = ${INTELCE_SDK_DIR}/empty
INTELCE_AVCAP_SAMPLES_SITE_METHOD = local
INTELCE_AVCAP_SAMPLES_LICENSE = PROPRIETARY
INTELCE_AVCAP_SAMPLES_REDISTRIBUTE = NO
INTELCE_AVCAP_SAMPLES_DEPENDENCIES = intelce-sdk intelce-avcap intelce-display intelce-bufmon intelce-common intelce-vidrend intelce-vidpproc intelce-viddec intelce-audio intelce-core intelce-demux intelce-clock intelce-clock_recovery intelce-smd_tools intelce-smd_sample_apps
INTELCE_AVCAP_SAMPLES_INSTALL_STAGING = YES

INTELCE_AVCAP_SAMPLES_BUILD_ENV = \
	BUILD_TARGET_DIR=${INTELCE_AVCAP_SAMPLES_DIR} \
	BUILD_SMD_COMMOM=false BUILD_SMD_TOOLS=true

define INTELCE_AVCAP_SAMPLES_CONFIGURE_CMDS
endef

define INTELCE_AVCAP_SAMPLES_BUILD_CMDS
	if [ -d "${INTELCE_AVCAP_SAMPLES_DIR}/build_i686" ]; then \
		 rm -rf "${INTELCE_AVCAP_SAMPLES_DIR}/build_i686"; \
	fi
	if [ -d "${INTELCE_AVCAP_SAMPLES_DIR}/binaries" ]; then \
		 rm -rf "${INTELCE_AVCAP_SAMPLES_DIR}/binaries"; \
	fi
	if [ -d "${INTELCE_AVCAP_SAMPLES_DIR}/project_build_i686" ]; then \
		 rm -rf "${INTELCE_AVCAP_SAMPLES_DIR}/project_build_i686"; \
	fi
	${INTELCE_AVCAP_SAMPLES_BUILD_ENV} ${INTELCESDK-BUILD} avcap_samples
endef

define INTELCE_AVCAP_SAMPLES_INSTALL_STAGING_CMDS
	$(call INTELCE_SDK_INSTALL_TO_STAGING,${INTELCE_AVCAP_SAMPLES_DIR}/build_i686/staging_dir) 
endef

define INTELCE_AVCAP_SAMPLES_INSTALL_TARGET_CMDS
	$(call INTELCE_SDK_INSTALL_TO_TARGET,${INTELCE_AVCAP_SAMPLES_DIR}/project_build_i686/IntelCE/root)
endef

$(eval $(generic-package))
