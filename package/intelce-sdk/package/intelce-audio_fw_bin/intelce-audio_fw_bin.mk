################################################################################
#
# intelce-audio_fw_bin
#
################################################################################
INTELCE_AUDIO_FW_BIN_VERSION = 9c7b26f9196dbb2a55fe26fd64cbc2374b5b8029
INTELCE_AUDIO_FW_BIN_SITE = git@github.com:Metrological/intelce-audio-fw-prebuilt.git
INTELCE_AUDIO_FW_BIN_SITE_METHOD = git
INTELCE_AUDIO_FW_BIN_LICENSE = PROPRIETARY
INTELCE_AUDIO_FW_BIN_REDISTRIBUTE = NO
INTELCE_AUDIO_FW_BIN_INSTALL_STAGING = YES

define INTELCE_AUDIO_FW_BIN_INSTALL_TARGET_CMDS
    $(INSTALL) -m 755 -d ${TARGET_DIR}/lib/firmware/smd
    $(INSTALL) -m 644 -D ${INTELCE_AUDIO_FW_BIN_DIR}/audio_fw_dsp0.bin ${TARGET_DIR}/lib/firmware/smd/
    $(INSTALL) -m 644 -D ${INTELCE_AUDIO_FW_BIN_DIR}/audio_fw_dsp1.bin ${TARGET_DIR}/lib/firmware/smd/
endef

$(eval $(generic-package))
